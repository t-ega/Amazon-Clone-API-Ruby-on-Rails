require 'jwt'

class ApplicationController < ActionController::API
  include Api::V1::Authentication

  rescue_from Api::V1::ApplicationError do | ex |
    response_handler(ex)
  end

  def response_handler(res)
    if res.kind_of? StandardError
      error_handler(res)
    end
  end

  def error_handler(e)
    code = e.config[:http_code] || 500
    render status: code, json: { success: false, error: e.message, code: e.code }
  end

end
