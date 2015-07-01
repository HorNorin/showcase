class StaticsController < ApplicationController
  def index
    redirect_to admin_root_path if admin_signed_in?
    @shows = Show.paginate page: params[:page], per_page: 12
  end
end
