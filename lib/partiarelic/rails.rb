require 'partiarelic'

if defined?(Rails)
  module Partiarelic
    class Railtie < Rails::Railtie
      initializer "partiarelic.rails_middleware" do |app|
        app.middleware.use Partiarelic::Middleware, '/_newrelic/manual_start'
      end
    end
  end
end
