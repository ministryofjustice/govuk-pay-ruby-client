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
        state.dig('status')
      end

      def finished?
        !!state.dig('finished')
      end

      def success?
        status.eql?(SUCCESS_STATUS)
      end
    end
  end
end
