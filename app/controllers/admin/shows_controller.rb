class Admin::ShowsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_show, except: [:index, :new, :create]
  
  def index
    @shows = Show.paginate(page: params[:page], per_page: 10)
  end
  
  def show
  end
  
  def new
    @show = Show.new
  end
  
  def create
    @show = Show.new show_params
    if @show.save
      flash[:success] = "One show has been added."
      redirect_to new_admin_show_path
    else
      render "new"
    end
  end
  
  def edit
  end
  
  def update
    video = @show.video.dup
    if @show.update_attributes show_params
      video.remove! if params[:show][:video]
      flash[:success] = "One show has been updated."
      redirect_to admin_shows_path
    else
      render "edit"
    end
  end
  
  def destroy
    @show.destroy
    @message = "One show has been deleted."
    flash[:success] = @message
    redirect_to admin_shows_path
  end
  
  private
  
  def show_params
    params.require(:show).permit :title, :description, :duration, :video, :remove_video,
                                 :youtube_url, :thumbnail, :remove_thumbnail,
                                 :attachment, :remove_attachment
  end
  
  def set_show
    @show = Show.find params[:id]
  end
end
