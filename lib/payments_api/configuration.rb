# frozen_string_literal: true

module PaymentsApi
  class Configuration
    attr_accessor :logger,
                  :api_root,
                  :api_key,
                  :open_timeout,
                  :read_timeout,
                  :http_client_class

    def initialize
      @api_root = 'https://publicapi.payments.service.gov.uk'

      @open_timeout = 10   # connection timeout in seconds
      @read_timeout = 20   # read timeout in seconds

      @http_client_class = PaymentsApi::HttpClient
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
