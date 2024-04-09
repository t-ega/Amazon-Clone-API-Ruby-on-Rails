module Api
module V1
  class AuthController < ApplicationController
    rescue_from ActionController::ParameterMissing, with: :exception_handler

    def create
      User.all.map(&:destroy)
      user = User.new(sign_up_params)
      if user.save
        user.send_confirmation_email!
        render json: ResponseFactory.format_response("Sign-up successful. Check email for confirmation token")
      else
        render json: ErrorFactory.format_message(user.errors.as_json), status: :bad_request
      end

    end

    def sign_in
      email, password = sign_in_params
      user = User.find_by(email: email)

      unless user.present?
        return render json: ErrorFactory.
          format_message("Incorrect email or password"), status: :bad_request
      end

      unless user.authenticate(password)
        render json: ErrorFactory.
          format_message("Incorrect email or password"), status: :bad_request
      end
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
      render json: ErrorFactory.format_message(exception.to_json), status: :bad_request
    end

    def sign_up_params
      params.require(:user).permit(:name,:email, :phone, :password, :password_confirmation)
    end
  end
end
end
