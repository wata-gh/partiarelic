require 'spec_helper'

module Partiarelic
  AppOriginal = App
end

RSpec.describe Partiarelic::Middleware do
  include Rack::Test::Methods
  let(:nextapp) { -> (env) { [200, {'Content-Type' => 'text/plain'}, ['hi']] } }
  let(:mockapp) do
    Class.new do
      def self.instances
        @instances ||= []
      end

      def initialize(**options)
        @options = options
        self.class.instances << self
      end

      attr_reader :file, :options

      def call(env)
        [200, {'Content-Type' => 'text/plain'}, "deadbeef"]
      end

      const_set(:ACCEPT_METHODS, %w[GET HEAD].freeze)
    end
  end
  let(:app) { Partiarelic::Middleware.new(nextapp, path: '/_newrelic/manual_start') }

  before do
    Partiarelic.send(:remove_const, :App)
    Partiarelic.const_set(:App, mockapp)
  end

  after do
    Partiarelic.send(:remove_const, :App)
    Partiarelic.const_set(:App, Partiarelic::AppOriginal)
  end

  context '' do
    it 'instantiates App with proper argument' do
      app

      expect(mockapp.instances.size).to eq(1)
      expect(mockapp.instances.first.options).to eq({path: '/_newrelic/manual_start'})
    end

    it 'pass-through requests to nextapp' do
      get '/'
      expect(last_response.body).to eq('hi')
      post '/'
      expect(last_response.body).to eq('hi')
      get '/_newrelic'
      expect(last_response.body).to eq('hi')
      post '/_newrelic/manual_start'
      expect(last_response.body).to eq('hi')
    end

    it 'pass requests to Partiarelic::App on specific path' do
      get '/_newrelic/manual_start'
      expect(last_response.body).to eq('deadbeef')

      head '/_newrelic/manual_start'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('deadbeef')
    end
  end
end
