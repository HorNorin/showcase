class ShowsController < ApplicationController
  before_action :auth_user, only: :show
  
  def index
    @shows = Show.paginate page: params[:page], per_page: 12
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @show = Show.find params[:id]
  end
  
  private
  
  def auth_user
    unless user_signed_in?
      flash[:error] = "You need to sign in before continue."
      redirect_to sign_in_path
    end
  end
end
