# frozen_string_literal: true

require 'json'
require 'logger'

require_relative 'payments/configuration'
require_relative 'payments/errors'
require_relative 'payments/http_client'

require_relative 'payments/requests/create_card_payment'
require_relative 'payments/responses/payment_result'

module Payments
end
