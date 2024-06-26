module Api
  module V1
    class ConfirmationsController < ApplicationController

      # Handles the creation of email confirmation requests
      def create

        user = User.find_by(email: confirmation_params.fetch(:email).downcase)

        if user.present? && user.unconfirmed?
          user.send_confirmation_email!
          success_handler("Email confirmation sent. Check email")
        else
          raise ApplicationError::BadRequest("We could not find a user with that email or that email has already been confirmed.")
        end
      end

      # Handles the confirmation of email through a token
      def edit
        user = User.find_signed(params[:confirmation_token], purpose: :confirm_email)
        if user.present?
          user.confirm!

          # Create a JWT token by encoding the user data
          token = encode_user_data(user.id)
          success_handler({token: token})
        else
          raise ApplicationError::BadRequest("Invalid token.")
        end
      end

      private

      # Permits the email parameter from the user object
      def confirmation_params
        params.require(:user).permit(:email)
      end

    end
  end
end