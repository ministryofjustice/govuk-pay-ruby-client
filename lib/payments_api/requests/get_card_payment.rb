# frozen_string_literal: true

module PaymentsApi
  module Requests
    class GetCardPayment
      include Traits::ApiRequest

      attr_reader :payment_id

      def initialize(payment_id:)
        @payment_id = payment_id
      end

      def call
        Responses::PaymentResult.new(
          http_client.get(endpoint)
        )
      end

      def endpoint
        format(
          '/v1/payments/%<payment_id>s', payment_id: payment_id
        )
      end
    end
  end
end
