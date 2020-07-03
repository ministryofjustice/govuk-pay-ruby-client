# frozen_string_literal: true

module PaymentsApi
  module Requests
    class GetCardPayment
      include Traits::ApiRequest

      attr_reader :payment_id

      # Instantiate a get payment details request
      #
      # @param payment_id [String] The payment ID to retrieve their information
      #
      # @raise [ArgumentError] if +payment_id+ is missing or +nil+
      # @return [PaymentsApi::Requests::GetCardPayment] instance
      #
      # @see https://govukpay-api-browser.cloudapps.digital/#get-a-payment
      #
      def initialize(payment_id:)
        @payment_id = payment_id

        raise ArgumentError, '`payment_id` cannot be nil' unless payment_id
      end

      # Get existing payment details
      #
      # @raise [PaymentsApi::Errors::ApiError] refer to lib/payments_api/errors.rb
      # @return [Responses::PaymentResult] result response
      #
      # @see https://govukpay-api-browser.cloudapps.digital/#tocsgetpaymentresult
      #
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
