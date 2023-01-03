# frozen_string_literal: true

require "graphql"

module GraphQL
  module Constraint
    module Directive
      class Constraint < GraphQL::Schema::Directive
        LENGTH = { min_length: :minimum, max_length: :maximum }.freeze

        description "validate GraphQL fields"
        argument :max_length, Int, required: false, description: "validate max length for String"
        argument :min_length, Int, required: false, description: "validate min length for String"
        locations INPUT_FIELD_DEFINITION

        def initialize(owner, **arguments)
          super
          owner.validates(validation_config)
        end

        private

        def validation_config
          {
            length: length_config
          }
        end

        def length_config
          filtered_args = arguments.keyword_arguments.filter { |key, _| LENGTH.key?(key) }

          if owner.type != GraphQL::Types::String
            raise ArgumentError, <<~MD
              #{filtered_args.keys.join(", ")} in @constraint can't be attached to #{owner.graphql_name} because it has to be a String type.
            MD
          end

          filtered_args.transform_keys { |key| LENGTH[key] }
        end
      end
    end
  end
end
