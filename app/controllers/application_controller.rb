require 'jwt'

class ApplicationController < ActionController::API
  include Api::V1::Authentication

  rescue_from ActionController::ParameterMissing do |ex|
    err = Api::V1::ApplicationError::BadRequest(ex.message)
    puts err.inspect
    error_handler(err)
  end

  rescue_from Api::V1::ApplicationError do | ex |
    response_handler(ex)
  end

  def response_handler(res)
    if res.kind_of? Api::V1::ApplicationError
      error_handler(res)
    else
      success_handler(res)
    end
  end

  def success_handler(res)
    render status: 200, json: { success: true, data: res }
  end

  def error_handler(e)
    code = e.http_code || 500
    render status: code, json: { success: false, error: e.message }
  end


end
