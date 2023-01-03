# frozen_string_literal: true

RSpec.describe GraphQL::Constraint::Directive::Constraint do
  let(:query) do
    <<~GRAPHQL
      mutation($input: SampleMutationInput!) {
        sample(input: $input) {
          text
          extraArgs
        }
      }
    GRAPHQL
  end

  context "with violated" do
    let(:expected) do
      {
        "data" => {
          "sample" => nil
        },
        "errors" => [
          {
            "message" => message,
            "locations" => [
              {
                "line" => 2,
                "column" => 3
              }
            ],
            "path" => [
              "sample"
            ]
          }
        ]
      }
    end

    context "when min is violated" do
      let(:variables) { { input: { text: "" } } }
      let(:message) { "text is too short (minimum is 1)" }

      it "is returns error" do
        expect(Schema.execute(query: query, variables: variables).to_json).to be_json_as(expected)
      end
    end

    context "when max is violated" do
      let(:variables) { { input: { text: "wow" } } }
      let(:message) { "text is too long (maximum is 2)" }

      it "is returns error" do
        expect(Schema.execute(query: query, variables: variables).to_json).to be_json_as(expected)
      end
    end
  end

  context "when valid argument" do
    let(:variables) { { input: { text: "yo", extraArgs: "foo" } } }
    let(:expected) do
      {
        "data" => {
          "sample" => {
            "text" => "yo",
            "extraArgs" => "foo"
          }
        }
      }
    end

    it "returns data" do
      expect(Schema.execute(query: query, variables: variables).to_json).to be_json_as(expected)
    end
  end
end
