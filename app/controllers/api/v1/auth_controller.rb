class AuthController < ApplicationController
  def create

  end

  def sign_in

  end

  def sign_out

  end

  private
  def signin_params
    params.require
  end
end
