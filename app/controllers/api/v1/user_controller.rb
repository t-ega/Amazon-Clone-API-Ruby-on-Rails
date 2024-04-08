class UserController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.as_json
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end
end
