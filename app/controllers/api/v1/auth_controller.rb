module Api
module V1
  class AuthController < ApplicationController

    def create
      User.all.map(&:destroy)
      user = User.new(sign_up_params)

      if user.save
        user.send_confirmation_email!
        success_handler("Sign-up successful. Check email for confirmation token", :created)
      else
        raise ApplicationError::BadRequest(user.errors)
      end

    end

    def sign_in
      email, password = sign_in_params
      user = User.find_by(email: email)

      unless user.present?
        raise ApplicationError::BadRequest("Incorrect email or password")
      end

      unless user.authenticate(password)
        raise ApplicationError::BadRequest("Incorrect email or password")
      end

      # Create a JWT token by encoding the user data
      token = encode_user_data(user.id)
      success_handler({token: token})
    end

    def sign_out

    end

    private
    def sign_in_params
      email = params.require(:email).downcase
      password = params.require(:password)
      [email, password]
    end

    def exception_handler(exception)
      raise ApplicationError::BadRequest(exception.to_json)
    end

    def sign_up_params
      params.require(:user).permit(:name,:email, :phone, :password, :password_confirmation)
    end
  end
end
end
