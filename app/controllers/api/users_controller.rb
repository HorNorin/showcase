class Api::UsersController < ApplicationController
  def validate_email
    render json: User.where(email: params[:email]).count == 0
  end
end
