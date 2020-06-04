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

      def initialize(amount:, reference:, description:, return_url:, **optional_details)
        @optional_details = optional_details

        @amount = amount
        @reference = reference
        @description = description
        @return_url = return_url
      end

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
