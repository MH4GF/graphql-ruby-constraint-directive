# frozen_string_literal: true

require_relative "directive/version"
require_relative "directive/constraint"

module GraphQL
  module Constraint
    module Directive
      class Error < StandardError; end

      def self.use(schema_defn)
        schema_defn.directive(Constraint)
      end
    end
  end
end
