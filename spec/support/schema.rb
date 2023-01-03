# frozen_string_literal: true

class BaseMutation < GraphQL::Schema::RelayClassicMutation
end

class SampleMutation < BaseMutation
  argument :text, String, required: true,
                          directives: { GraphQL::Constraint::Directive::Constraint => { min_length: 1, max_length: 2 } }
  argument :extra_args, String, required: false

  field :text, String, null: true
  field :extra_args, String, null: true

  def resolve(text:, extra_args: nil)
    {
      text: text,
      extra_args: extra_args
    }
  end
end

class MutationType < GraphQL::Schema::Object
  field :sample, mutation: SampleMutation
end

class Schema < GraphQL::Schema
  mutation MutationType

  use GraphQL::Constraint::Directive
end
