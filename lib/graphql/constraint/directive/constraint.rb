# frozen_string_literal: true

require "graphql"

module GraphQL
  module Constraint
    module Directive
      class Constraint < GraphQL::Schema::Directive
        LENGTH = { min_length: :minimum, max_length: :maximum }.freeze
        NUMERICALITY = { min: :greater_than_or_equal_to, max: :less_than_or_equal_to }.freeze

        description "validate GraphQL fields"
        argument :max_length, Int, required: false, description: "validate max length for String"
        argument :min_length, Int, required: false, description: "validate min length for String"
        argument :max, Int, required: false, description: "validate max length for Int"
        argument :min, Int, required: false, description: "validate min length for Int"
        locations INPUT_FIELD_DEFINITION

        def initialize(owner, **arguments)
          super
          owner.validates(validation_config)
        end

        private

        def validation_config
          {}.then { length_config.nil? ? _1 : _1.merge(length_config) }
            .then { numericality_config.nil? ? _1 : _1.merge(numericality_config) }
        end

        def length_config
          filtered_args = arguments.keyword_arguments.filter { |key, _| LENGTH.key?(key) }
          return if filtered_args.empty?

          assert_valid_owner_type_and_args(GraphQL::Types::String, filtered_args)

          {
            length: filtered_args.transform_keys { |key| LENGTH[key] }
          }
        end

        def numericality_config
          filtered_args = arguments.keyword_arguments.filter { |key, _| NUMERICALITY.key?(key) }
          return if filtered_args.empty?

          assert_valid_owner_type_and_args(GraphQL::Types::Int, filtered_args)

          {
            numericality: filtered_args.transform_keys { |key| NUMERICALITY[key] }
          }
        end

        def assert_valid_owner_type_and_args(type, args)
          return if owner_type == type

          raise ArgumentError, <<~MD
            #{args.keys.join(", ")} in @constraint can't be attached to #{owner.graphql_name} because it has to be a #{owner_type} type.
          MD
        end

        def owner_type
          owner.type.non_null? ? owner.type.of_type : owner.type
        end
      end
    end
  end
end
