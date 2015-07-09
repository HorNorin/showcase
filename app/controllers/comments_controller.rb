class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.create comment_params
  end

  def destroy
    @comment = current_user.comments.find params[:id]
  end

  private

  def comment_params
    params.require(:comment).permit :show_id, :user_id, :body
  end
end
