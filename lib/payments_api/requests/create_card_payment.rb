# frozen_string_literal: true

module PaymentsApi
  module Requests
    class CreateCardPayment
      include Traits::ApiRequest

      attr_reader :amount,
                  :reference,
                  :description,
                  :return_url,
                  :optional_details

      # Instantiate a new payment
      #
      # @param amount [Integer] The amount in pence, for instance, 14500 for 145
      # @param reference [String] The reference you wish to associate with this payment
      # @param description [String] A human-readable description of the payment that
      #   the user will see on the payment pages and admin tool
      # @param return_url [String] This is a URL that your service hosts for the user
      #   to return to, after their payment journey on GOV.UK Pay ends
      # @option optional_details [Hash] Additional properties to be sent in the payload,
      #   for example +email+ or +metadata+
      #
      # @raise [ArgumentError] if any of the mandatory params above are missing
      # @return [PaymentsApi::Requests::CreateCardPayment] instance
      #
      # @see https://govukpay-api-browser.cloudapps.digital/#create-a-payment
      #
      def initialize(amount:, reference:, description:, return_url:, **optional_details)
        @optional_details = optional_details

        @amount = amount
        @reference = reference
        @description = description
        @return_url = return_url
      end

      # Create a new payment
      #
      # @raise [PaymentsApi::Errors::ApiError] refer to lib/payments_api/errors.rb
      # @return [Responses::PaymentResult] result response
      #
      # @see https://govukpay-api-browser.cloudapps.digital/#tocscreatecardpaymentrequest
      # @see https://govukpay-api-browser.cloudapps.digital/#tocscreatepaymentresult
      #
      def call
        Responses::PaymentResult.new(
          http_client.post(endpoint, payload)
        )
      end

      def endpoint
        '/v1/payments'
      end

      def payload
        {
          amount: amount,
          reference: reference,
          description: description,
          return_url: return_url
        }.merge(
          optional_details
        )
      end
    end
  end
end
