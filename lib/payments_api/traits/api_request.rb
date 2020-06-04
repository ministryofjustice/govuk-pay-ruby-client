# frozen_string_literal: true

module PaymentsApi
  module Traits
    module ApiRequest
      def call
        raise 'implement in subclasses'
      end

      def endpoint
        raise 'implement in subclasses'
      end

      def payload
        {}
      end

      def query
        {}
      end

      def headers
        {}
      end

      private

      def http_client
        @_http_client ||= PaymentsApi.configuration.http_client_class.new
      end
    end
  end
end
