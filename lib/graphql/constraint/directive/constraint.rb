# frozen_string_literal: true

require "graphql"

module GraphQL
  module Constraint
    module Directive
      class Constraint < GraphQL::Schema::Directive
        LENGTH = { min_length: :minimum, max_length: :maximum }.freeze

        description "validate GraphQL fields"
        argument :max_length, Int, required: false, description: "validate max length"
        argument :min_length, Int, required: false, description: "validate min length"
        locations INPUT_FIELD_DEFINITION

        def initialize(owner, **arguments)
          super
          owner.validates(validation_config)
        end

        private

        def validation_config
          {
            length: arguments.keyword_arguments.filter { |key, _| LENGTH.key?(key) }.transform_keys { |key| LENGTH[key] }
          }
        end
      end
    end
  end
end
