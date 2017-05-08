require 'partiarelic/app'

module Partiarelic
  class Middleware
    def initialize(app, path, options={})
      @path = path
      @app = app
      @partiarelic_app = App.new(**options)
    end

    ACCEPT_METHODS = %w[GET HEAD].freeze

    def call(env)
      if env['PATH_INFO'] == @path && ACCEPT_METHODS.include?(env['REQUEST_METHOD'])
        @partiarelic_app.call(env)
      else
        @app.call(env)
      end
    end
  end
end
