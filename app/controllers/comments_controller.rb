class CommentsController < ApplicationController
  def create
    @intrigue = IntrigueItem.find(params[:intrigue_item_id])
    @comment = @intrigue.comments.build params[:comment]
    @comment.user = current_user
    @comment.save
    redirect_to @intrigue
  end
end
