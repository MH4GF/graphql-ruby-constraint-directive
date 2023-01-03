# frozen_string_literal: true

require_relative "lib/graphql/constraint/directive/version"

Gem::Specification.new do |spec|
  spec.name = "graphql-constraint-directive"
  spec.version = Graphql::Constraint::Directive::VERSION
  spec.authors = ["MH4GF"]
  spec.email = ["h.miyagi.cnw@gmail.com"]

  spec.summary = "Validate GraphQL Fields for graphql-ruby"
  spec.description = "Allow using @constraint as a directive to validate input data. inspired by https://github.com/confuser/graphql-constraint-directive"
  spec.homepage = "https://github.com/mh4gf/graphql-ruby-constraint-directive"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "graphql", "~> 2.0", ">= 2.0.16"
end
