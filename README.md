# GqlClient

GraphQl Client gem to make requests using GraphQL Query Language.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gql_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gql_client

## Usage
```
require 'gql_client'

url = "http://example.com/graphql"
headers = {
    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9"
}

query = <<~GRAPHQL
{
  infoForItem(id: 1234) 
    {
      id
      name
      size
    }
}
GRAPHQL
```
### Single Request
```
response = GqlClient.execute(url, query, headers)
```

### Session based Request

```
session = GqlClient::Session.new(url, headers)
response = session.execute(query)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lezwon/GqlClient.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).