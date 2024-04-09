class UserController < ApplicationController

  def edit
    @user = User.find(params[:id])
    render json: ErrorFactory.format_message("User not found", :not_found),
           status: :not_found unless @user

  #   TODO: Handle editing of a users account
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end
end
