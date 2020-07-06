# frozen_string_literal: true

require 'json'
require 'logger'

require_relative 'payments_api/version'
require_relative 'payments_api/configuration'
require_relative 'payments_api/errors'
require_relative 'payments_api/http_client'

require_relative 'payments_api/traits/api_request'

require_relative 'payments_api/requests/create_card_payment'
require_relative 'payments_api/requests/get_card_payment'

require_relative 'payments_api/responses/payment_result'

module PaymentsApi
end
