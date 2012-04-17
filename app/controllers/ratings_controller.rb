class RatingsController < ApplicationController
  def create
    @intrigue = IntrigueItem.find(params[:intrigue_item_id])
    @rating = @intrigue.ratings.build params[:rating]
    @rating.user = current_user
    @rating.save!
    redirect_to @intrigue
  end
end
