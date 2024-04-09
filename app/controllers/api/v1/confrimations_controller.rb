module Api
  module V1
    class ConfirmationsController < ApplicationController

      # Handles the creation of email confirmation requests
      def create
        puts edit_confirmation_params
        user = User.find_by(email: confirmation_params.fetch(:email).downcase)

        if user.present? && user.unconfirmed?
          render json: ResponseFactory.format_response("Email confirmation sent. Check email")
        else
          render json: ErrorFactory.format_message("We could not find a user with that email or that email has already been confirmed.")
        end
      end

      # Handles the confirmation of email through a token
      def edit
        user = User.find_signed(edit_confirmation_params.fetch(:confirmation_token), purpose: :confirm_email)
        if user.present?
          user.confirm!
          render json: ResponseFactory.format_response("Successfully confirmed")
        else
          render json: ErrorFactory.format_message("Invalid token.")
        end
      end

      private

      # Retrieves the confirmation token from the request parameters
      def edit_confirmation_params
        params.require(:confirmation_token)
      end

      # Permits the email parameter from the user object
      def confirmation_params
        params.require(:user).permit(:email)
      end

    end
  end
end