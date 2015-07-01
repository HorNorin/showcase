class Admin::ShowsController < ApplicationController
  #before_action :authenticate_admin!
  before_action :set_show, except: [:index, :new, :create]
  
  def index
    @shows = Show.paginate(page: params[:page], per_page: 10)
  end
  
  def show
  end
  
  def new
    @show = Show.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @show = Show.new show_params
    respond_to do |format|
      @message = "One show has been added."
      if @show.save
        format.html do
          flash[:success] = @message
          redirect_to new_admin_show_path
        end
      else
        format.html { render "new" }
      end
      
      format.js
    end
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      @message = "One show has been updated."
      video = @show.video.dup
      
      if @show.update_attributes show_params
        video.remove! if params[:show][:video]
        format.html do
          flash[:success] = @message
          redirect_to admin_shows_path
        end
      else
        format.html { render "edit" }
      end
      
      format.js
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
    params.require(:show).permit :title, :description, :video, :remove_video,
                                 :youtube_url, :thumbnail, :remove_thumbnail,
                                 :attachment, :remove_attachment
  end
  
  def set_show
    @show = Show.find params[:id]
  end
end
