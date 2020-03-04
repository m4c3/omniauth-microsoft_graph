# frozen_string_literal: true

require 'bundler/setup'
require 'minitest/autorun'
require 'mocha/setup'
require 'omniauth/strategies/microsoft_graph'

OmniAuth.config.test_mode = true

class StrategyTestCase < Minitest::Test
  def setup
    @request = stub('Request')
    @request.stubs(:params).returns({})
    @request.stubs(:cookies).returns({})
    @request.stubs(:env).returns({})
    @request.stubs(:scheme).returns({})
    @request.stubs(:ssl?).returns(false)

    @client_id = '00000000-1111-1111-1111-000000000000'
    @client_secret = 'asdfasdfasdfasdfasdfasdfasdfasdf'
    @tenant_id = '00000000-0000-0000-0000-000000000000'
    @options = {}
  end

  def strategy
    @strategy ||= begin
      args = [@client_id, @client_secret, @tenant_id, @options].compact
      OmniAuth::Strategies::MicrosoftGraph.new(nil, *args).tap do |strategy|
        strategy.stubs(:request).returns(@request)
      end
    end
  end
end
