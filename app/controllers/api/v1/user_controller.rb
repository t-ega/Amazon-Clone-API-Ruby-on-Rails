class UserController < ApplicationController

  def edit
    @user = User.find(params[:id])
    raise ApplicationError::NotFound("User not found") unless @user

  #   TODO: Handle editing of a users account
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end
end
