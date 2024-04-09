# frozen_string_literal: true

class ErrorFactory
  def self.format_message(message, status_code=:bad_request)
    # If the given status code is not found, instead of failing it should just return 400
    numerical_status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE.fetch(status_code, 400)
    { :status => numerical_status_code, :success => false,
      :error => message, :timestamp => Time.now
    }.as_json
  end

end
