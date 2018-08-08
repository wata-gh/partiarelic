require 'partiarelic/grpc/partiarelic_services_pb.rb'
require 'newrelic_rpm'

module Partiarelic
  class GrpcApp < Partiarelic::V1::App::Service
    def manual_start(reqeust_, call_)
      NewRelic::Agent.manual_start
      Partiarelic::V1::ManualStartResponse.new
    end
  end
end
