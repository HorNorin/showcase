class ShowsController < ApplicationController
  # before_action :auth_user, only: :show
  before_action :authenticate_user!, only: :show
  
  def index
    respond_to do |format|
      format.html do
        if params[:title]
          @shows = Show.where("title = ?", params[:title]).paginate page: params[:page], per_page: 12
        else
          @shows = Show.paginate page: params[:page], per_page: 12
        end
      end
    end
  end
  
  def show
    @show = Show.find params[:id]
  end
  
  # private
  
  # def auth_user
  #   unless user_signed_in?
  #     flash[:error] = "You need to sign in before continue."
  #     redirect_to sign_in_path
  #   end
  # end
end
