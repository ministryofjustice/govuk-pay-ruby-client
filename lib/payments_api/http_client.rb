# frozen_string_literal: true

require 'faraday'

module PaymentsApi
  class HttpClient
    include Errors

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    # Only GET and POST verbs are used with Payments API, but more
    # verbs can be easily added as needed.

    def get(href, query = {})
      execute_request!(:get, href) do |req|
        req.params.update(query)
      end
    end

    def post(href, payload = {})
      execute_request!(:post, href) do |req|
        req.body = JSON.dump(payload)
      end
    end

    private

    def config
      PaymentsApi.configuration
    end

    def execute_request!(verb, href)
      response = connection.send(verb) do |req|
        req.url(href)
        req.headers.update(config.request_headers)

        yield(req) if block_given?
      end

      handle_response(
        response
      )
    rescue Faraday::Error => e
      raise ConnectionError, e
    end

    def handle_response(response)
      parsed_body = JSON.parse(response.body)
      status_code = response.status

      raise_error!(parsed_body, status_code) unless response.success?

      parsed_body
    end

    def connection
      Faraday.new(url: config.api_root) do |conn|
        conn.authorization(:Bearer, config.api_key)

        conn.response(:logger, options.fetch(:logger, config.logger), bodies: false) do |logger|
          logger.filter(/(Authorization:) "(Bearer .*)"/, '\1[REDACTED]')
        end

        conn.options.open_timeout = options.fetch(
          :open_timeout, config.open_timeout
        )
        conn.options.timeout = options.fetch(
          :read_timeout, config.read_timeout
        )
      end
    end
  end
end
