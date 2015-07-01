class StaticsController < ApplicationController
  def index
    redirect_to admin_root_path if admin_signed_in?
  end
end
