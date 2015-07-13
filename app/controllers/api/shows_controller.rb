class Api::ShowsController < ApplicationController
  def index
    render json: Show.search(params[:title]).records
  end
end
