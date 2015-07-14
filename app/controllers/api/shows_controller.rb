class Api::ShowsController < ApplicationController
  def index
    if params[:title]
      render json: Show.search(params[:title]).records
    else
      @shows = Show.paginate(page: params[:page], per_page: 12)
      
      render json: {
        shows: @shows,
        current: @shows.current_page,
        nextPage: @shows.next_page,
        prevPage: @shows.previous_page,
        totalPages: @shows.total_pages,
      }
    end
  end
  
  def show
    render json: Show.find(params[:id])
  end
end
