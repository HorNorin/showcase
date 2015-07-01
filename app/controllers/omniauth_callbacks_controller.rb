class OmniauthCallbacksController < ApplicationController
  before_action :sign_up_user
  
  def twitter
  end
  
  def facebook
  end
  
  private
  
  def sign_up_user
    user = User.sign_up_with_omniauth request.env["omniauth.auth"]
    if user
      flash[:success] = "You have signed in successfully."
      sign_in_and_redirect user
    else
      flash[:error] = "An error ocurred. Please contact support team for help."
      redirect_to new_user_registration_path
    end
  end
end
