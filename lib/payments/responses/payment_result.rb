# frozen_string_literal: true

module Payments
  module Responses
    class PaymentResult
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
        card_details
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
    end
  end
end
