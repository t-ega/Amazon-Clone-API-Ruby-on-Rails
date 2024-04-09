# frozen_string_literal: true

class ResponseFactory
  def self.format_response(message, status_code=:ok)
    # If the given status code is not found, instead of failing it should just return 200
    numerical_status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE.fetch(status_code, 200)

    {
      :status => numerical_status_code,
      :success => true,
      :message => message
    }.to_json
  end
end