class Admin::SessionsController < Devise::SessionsController
  before_action :redirect_signed_in_user
  
  def new
    super
  end
  
  def create
    user = User.find_by email: params[:user][:email]
    if user && user.admin?
      super
    else
      flash[:error] = "Invalid email or password. Are you an admin?"
      redirect_to new_admin_session_path
    end
  end
  
  private
  
  def redirect_signed_in_user
    if user_signed_in?
      flash[:error] = "Access denied. You don't have permission to access this page"
      redirect_to root_path
    end
  end
end
