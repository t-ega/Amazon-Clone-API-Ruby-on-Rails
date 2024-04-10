require 'jwt'

class ApplicationController < ActionController::API
  # TODO: Store secret in ENV
  SECRET = "mys3cr3tk3y"
  EXPIRY_TIME = Time.now.to_i + 1.day

  def authenticate
    #  An authenticated user is determined by them passing a Bearer <token>
    # in the request headers. if this is present we validate it to get the user Id if
    # validation fails we know that the token is invalid

    bearer_token = request.headers.fetch("Authorization", nil)
    return render json: ErrorFactory.format_message("Bearer <token> required",
                                                    :unauthorized), status: :unauthorized unless bearer_token

    stripped_token =  bearer_token.to_s.gsub("Bearer ", "")
    decode_data = decode_user_data(stripped_token)

    # getting user id from a nested JSON in an array.
    user_id = decode_data[0]["user_id"] if decode_data

    return render json: ErrorFactory.format_message("Invalid token"), status: :unauthorized unless user_id

    # find a user in the database to be sure token is for a real user
    user = User.find(user_id)

    return true if user
    render json: ErrorFactory.format_message("Token has expired or invalid")
  end

  # decode token and return user info, this returns an array, [payload and algorithms]
  def decode_user_data(token)
    begin
      JWT.decode token, SECRET, true, { algorithm: "HS256" }
    rescue => e
      # TODO: Implement logging of error
      puts e
    end
  end

  # turn user data (payload) to an encrypted string.
  # This token is usually valid for 1 day
  def encode_user_data(payload)
    payload = {user_id: payload, exp: EXPIRY_TIME}
    JWT.encode payload, SECRET, 'HS256'
  end

end
