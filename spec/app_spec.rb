require 'spec_helper'

RSpec.describe Partiarelic::App do
  include Rack::Test::Methods

  context 'with default' do
    let(:app) { described_class.new }

    before do
      allow(NewRelic::Agent).to receive(:manual_start).once
    end

    it 'returns started with get' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(Socket.gethostname)
    end

    it 'returns empty with head' do
      head '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq('')
    end
  end

  context 'with path' do
    let(:app) { described_class.new(path: '/_newrelic/manual_start') }

    context 'path not match' do
      before do
        allow(NewRelic::Agent).to receive(:manual_start).and_raise('should not start NewRelic')
      end

      it 'returns 404 with get' do
        get '/'
        expect(last_response.status).to eq(404)
      end

      it 'returns 404 with head' do
        head '/'
        expect(last_response.status).to eq(404)
      end

      it 'returns 404 with post' do
        post '/'
        expect(last_response.status).to eq(404)
      end
    end

    context 'path match' do
      before do
        allow(NewRelic::Agent).to receive(:manual_start).once
      end

      it 'returns started with get' do
        get '/_newrelic/manual_start'
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq(Socket.gethostname)
      end

      it 'returns emptry with head' do
        head '/_newrelic/manual_start'
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq('')
      end

      it 'returns 404 with post' do
        post '/_newrelic/manual_start'
        expect(last_response.status).to eq(404)
      end
    end
  end
end
