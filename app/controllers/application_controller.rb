require 'jwt'

class ApplicationController < ActionController::API
  include Api::V1::Authentication

  rescue_from ActionController::ParameterMissing do |ex|
    err = Api::V1::ApplicationError::BadRequest(ex.message)
    error_handler(err)
  end

  rescue_from Api::V1::ApplicationError do | ex |
    error_handler(ex)
  end

  def success_handler(res, status_code=:ok)
    numerical_status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE.fetch(status_code, 200)
    render status: status_code, json: { success: true, status: numerical_status_code, data: res }
  end

  def error_handler(e)
    code = e.http_code || 500
    render status: code, json: { success: false, error: e.message }
  end


end
