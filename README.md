# Partiarelic

[![Build Status](https://travis-ci.org/wata-gh/partiarelic.svg)](https://travis-ci.org/wata-gh/partiarelic)

Adds endpoint to enable New Relic manually.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'partiarelic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install partiarelic

## Usage

### typical Rails app

```ruby
# Gemfile
gem 'partiarelic', require: 'partiarelic/rails'
```

then your Rails application will handle `/_newrelic/manual_start`.

### rack application

```ruby
# Gemfile
gem 'partiarelic'

# config.ru (middleware)
use Partiarelic::Middleware, path: '/_newrelic/manual_start'

# config.ru (mount)
map '/_newrelic/manual_start' do
  run Partiarelic::App.new(path: '/_newrelic/manual_start')
end
```

### gRPC application

```ruby
# Gemfile
gem 'partiarelic', require 'partiarelic/grpc'

# server
s = GRPC::RpcServer.new
s.add_http2_port(host, :this_port_is_insecure)
s.handle(Partiarelic::GrpcApp)
s.run_till_terminated

# client
require 'partiarelic/grpc/partiarelic_services_pb.rb'
stub = Partiarelic::V1::App::Stub.new(host, :this_channel_is_insecure)
stub.manual_start(Partiarelic::V1::ManualStartRequest.new)
```

## Development

### Test

```sh
$ rake spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wata-gh/partiarelic.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

