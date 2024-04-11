# frozen_string_literal: true

module Api
  module V1

    # This module would serve as the middleware holder for all authentication logic
    module Authentication
      extend ActiveSupport::Concern

      # TODO: Store secret in ENV
      SECRET = "mys3cr3tk3y"
      EXPIRY_TIME = Time.now.to_i + 1.day

      # An authenticated user is determined by them passing a Bearer <token>
      # in the request headers. if this is present we validate it to get the user Id if
      # validation fails we know that the token is invalid
      def authenticate

        bearer_token = request.headers.fetch("Authorization", nil)
        raise Api::V1::ApplicationError::Unauthorized("Bearer <token> required") unless bearer_token

        stripped_token =  bearer_token.to_s.gsub("Bearer ", "")
        decode_data = decode_user_data(stripped_token)

        # getting user id from a nested JSON in an array.
        user_id = decode_data[0]["user_id"] if decode_data

        raise Api::V1::ApplicationError::Unauthorized("Invalid token") unless user_id

        # find a user in the database to be sure token is for a real user
        user = User.find(user_id)

        return true if user
        raise Api::V1::ApplicationError::Unauthorized("Token has expired or invalid")
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

  end
end

