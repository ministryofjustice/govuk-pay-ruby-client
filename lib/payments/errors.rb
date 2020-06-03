# frozen_string_literal: true

require_relative 'errors'

module Payments
  module Errors
    def raise_error!(response_body, status_code)
      message = response_body.merge('http_code' => status_code)

      case status_code
      when 400 then raise BadRequest, message
      when 401 then raise Unauthorized, message
      when 404 then raise NotFoundError, message
      when 422 then raise InvalidRequest, message
      when 429 then raise ThrottleError, message
      when 500 then raise ServerError, message
      else
        raise ApiError, message
      end
    end

    class ApiError < StandardError; end

    class ClientError < ApiError; end
    class ServerError < ApiError; end

    class BadRequest < ClientError; end
    class NotFoundError < ClientError; end
    class InvalidRequest < ClientError; end
    class ThrottleError < ClientError; end
    class Unauthorized < ClientError; end
  end
end
