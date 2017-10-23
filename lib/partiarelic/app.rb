require 'pathname'
require 'newrelic_rpm'

module Partiarelic
  class App
    def initialize(path: nil)
      @path = path
    end

    ACCEPT_METHODS = ['GET', 'HEAD'].freeze

    def call(env)
      unless ACCEPT_METHODS.include?(env['REQUEST_METHOD']) && (@path ? env['PATH_INFO'] == @path : true)
        return [404, {'Content-Type' => 'text/plain'}, []]
      end

      NewRelic::Agent.manual_start

      headers = {'Content-Type' => 'text/plain'}
      if env['REQUEST_METHOD'] == 'HEAD'
        [200, headers, []]
      else
        [200, headers, [Socket.gethostname]]
      end
    end
  end
end
