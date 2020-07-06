# frozen_string_literal: true

module PaymentsApi
  class Configuration
    attr_accessor :logger,
                  :api_root,
                  :api_key,
                  :open_timeout,
                  :read_timeout,
                  :request_headers,
                  :http_client_class

    def initialize
      @api_root = 'https://publicapi.payments.service.gov.uk'

      @open_timeout = 10   # connection timeout in seconds
      @read_timeout = 20   # read timeout in seconds

      @request_headers = {
        'User-Agent' => "govuk-pay-ruby-client v#{PaymentsApi::VERSION}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }.freeze

      @http_client_class = PaymentsApi::HttpClient
    end
  end

  # Get current configuration
  #
  # @return [PaymentsApi::Configuration] current configuration
  #
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Configure the client
  #
  # Any attributes listed in +attr_accessor+ can be configured
  #
  # +api_root+, +open_timeout+, +read_timeout+ and +http_client_class+
  #   are set to sensible defaults already, but still can be changed
  #
  # +request_headers+ can also be changed or configured, but it is not
  #   recommended unless you know what you are doing
  #
  # @example
  #   PaymentsApi.configure do |config|
  #     config.api_key = 'secret'
  #   end
  def self.configure
    yield configuration
  end
end
