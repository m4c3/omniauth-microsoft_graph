# Omniauth::MicrosoftGraph [![Build Status](https://travis-ci.org/m4c3/omniauth-microsoft_graph.svg?branch=master)](https://travis-ci.org/m4c3/omniauth-microsoft_graph)

Microsoft Graph OAuth2 Strategy for OmniAuth.
Can be used to authenticate with Office365 or other MS services, and get a token for the Microsoft Graph Api, formerly the Office365 Unified Api.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-microsoft_graph', git: 'https://github.com/m4c3/omniauth-microsoft_graph'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-microsoft_graph

## Usage
include your Azure cententials in your .env file
```ini
AZURE_CLIENT_ID=''
AZURE_TENANT_ID=''
AZURE_CLIENT_SECRET=''
```

in Rails
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :microsoft_graph,
    {
      client_id: ENV['AZURE_CLIENT_ID'],
      client_secret: ENV['AZURE_CLIENT_SECRET'],
      tenant_id: ENV['AZURE_TENANT_ID']
    }
end
```

Or the alternative format for use with devise:

```ruby
config.omniauth :microsoft_graph, client_id: ENV['AZURE_CLIENT_ID'],
      client_secret: ENV['AZURE_CLIENT_SECRET'], tenant_id: ENV['AZURE_TENANT_ID']
```

## Contributing

1. Fork it ( https://github.com/m4c3/omniauth-microsoft_graph/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
