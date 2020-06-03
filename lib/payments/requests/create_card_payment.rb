# frozen_string_literal: true

module Payments
  module Requests
    class CreateCardPayment
      ENDPOINT = '/v1/payments'

      attr_accessor :amount,
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
          http_client.post(ENDPOINT, payload)
        )
      end

      private

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

      def http_client
        @_http_client ||= Payments::HttpClient.new
      end
    end
  end
end
