class IntrigueItemsController < ApplicationController
  before_filter :load_object


  protected
  def load_object
    @intrigue_item = IntrigueItem.find(params[:id])
  end
end
