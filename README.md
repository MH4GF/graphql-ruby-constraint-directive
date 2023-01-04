# GraphQL::Constraint::Directive
[![Tests](https://github.com/MH4GF/graphql-ruby-constraint-directive/actions/workflows/main.yml/badge.svg)](https://github.com/MH4GF/graphql-ruby-constraint-directive/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/graphql-constraint-directive.svg)](https://rubygems.org/gems/graphql-constraint-directive)

Allows using @constraint as a directive to validate input data. Inspired by [Constraints Directives RFC](https://github.com/IvanGoncharov/graphql-constraints-spec) and OpenAPI.  
This gem is an implementation of [graphql-constraint-directive](https://github.com/confuser/graphql-constraint-directive) in Ruby.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add graphql-constraint-directive

## Usage

This gem is an implemented as a plugin of [graphql-ruby](https://github.com/rmosolgo/graphql-ruby/). Attach to your schema as follows:

```ruby
class MySchema < GraphQL::Schema
  use GraphQL::Constraint::Directive
end
```

Then, set the directive to the argument for which you want to set validation:

```ruby
class CreateBook < BaseMutation
  argument :title, String,
           required: true,
           directives: { GraphQL::Constraint::Directive::Constraint => { min_length: 1, max_length: 200 } }

  field :book, Book, null: false

  def resolve(title:)
    # ...some codes
    {
      book: book
    }
  end
end
```

This will dump the following schema:

```graphql
input CreateBookInput {
  title: String! @constraint(minLength: 1, maxLength: 200)
}

type Mutation {
  createBook(
    input: CreateBookInput!
  ): CreateBookPayload
}
```

## API
### String
#### minLength
```@constraint(minLength: 5)```
Restrict to a minimum length

#### maxLength
```@constraint(maxLength: 5)```
Restrict to a maximum length

#### startsWith(unimplemented)
```@constraint(startsWith: "foo")```
Ensure value starts with foo

#### endsWith(unimplemented)
```@constraint(endsWith: "foo")```
Ensure value ends with foo

#### contains(unimplemented)
```@constraint(contains: "foo")```
Ensure value contains foo

#### notContains(unimplemented)
```@constraint(notContains: "foo")```
Ensure value does not contain foo

#### pattern(unimplemented)
```@constraint(pattern: "^[0-9a-zA-Z]*$")```
Ensure value matches regex, e.g. alphanumeric

### Int/Float
#### min
```@constraint(min: 3)```
Ensure value is greater than or equal to

#### max
```@constraint(max: 3)```
Ensure value is less than or equal to

#### exclusiveMin(unimplemented)
```@constraint(exclusiveMin: 3)```
Ensure value is greater than

#### exclusiveMax(unimplemented)
```@constraint(exclusiveMax: 3)```
Ensure value is less than

#### multipleOf(unimplemented)
```@constraint(multipleOf: 10)```
Ensure value is a multiple

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mh4gf/graphql-ruby-constraint-directive. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/graphql-ruby-constraint-directive/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Graphql::Ruby::Constraint::Directive project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/graphql-ruby-constraint-directive/blob/main/CODE_OF_CONDUCT.md).
