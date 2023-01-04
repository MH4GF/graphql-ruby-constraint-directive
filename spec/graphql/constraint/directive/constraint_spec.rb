# frozen_string_literal: true

RSpec.describe GraphQL::Constraint::Directive::Constraint do
  shared_examples "returns response" do
    it "returns response" do
      expect(Schema.execute(query: query, variables: variables).to_json).to be_json_as(expected)
    end
  end

  let(:query) do
    <<~GRAPHQL
      mutation($input: SampleMutationInput!) {
        sample(input: $input) {
          text
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

    context "when minLength is violated" do
      let(:variables) { { input: { text: "" } } }
      let(:message) { "text is too short (minimum is 1)" }

      it_behaves_like "returns response"
    end

    context "when maxLength is violated" do
      let(:variables) { { input: { text: "wow" } } }
      let(:message) { "text is too long (maximum is 2)" }

      it_behaves_like "returns response"
    end

    context "when min is violated" do
      let(:variables) { { input: { text: "yo", num: 0 } } }
      let(:message) { "num must be greater than or equal to 1" }

      it_behaves_like "returns response"
    end

    context "when max is violated" do
      let(:variables) { { input: { text: "yo", num: 3 } } }
      let(:message) { "num must be less than or equal to 2" }

      it_behaves_like "returns response"
    end
  end

  context "when valid argument" do
    let(:variables) { { input: { text: "yo", extraArgs: "foo" } } }
    let(:expected) do
      {
        "data" => {
          "sample" => {
            "text" => "yo"
          }
        }
      }
    end

    it_behaves_like "returns response"
  end
end
