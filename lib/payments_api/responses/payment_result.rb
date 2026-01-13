# frozen_string_literal: true

module PaymentsApi
  module Responses
    class PaymentResult
      SUCCESS_STATUS = 'success'

      FIELDS = %w[
        amount
        state
        description
        reference
        language
        payment_id
        return_url
        created_date
        metadata
        email
        refund_summary
        settlement_summary
        _links
      ].freeze

      attr_reader(*FIELDS)

      # Instantiate a payment result
      #
      # @note Not all properties returned by the API will be mapped to instance
      #   attributes in this class, but most common are included
      #
      # @param response [Hash] The API response for the operation, currently
      #   create a payment, or get details of an existing payment by ID
      #
      # @return [PaymentsApi::Responses::PaymentResult] instance
      #
      # @see https://govukpay-api-browser.cloudapps.digital/#tocscreatepaymentresult
      # @see https://govukpay-api-browser.cloudapps.digital/#tocsgetpaymentresult
      #
      def initialize(response)
        FIELDS.each do |field|
          instance_variable_set(:"@#{field}", response.fetch(field, nil))
        end
      end

      # URL where to redirect the user to capture their payment details
      def payment_url
        _links.dig('next_url', 'href')
      end

      def status
        state['status']
      end

      def finished?
        !!state['finished']
      end

      def success?
        status.eql?(SUCCESS_STATUS)
      end
    end
  end
end
