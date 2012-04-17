class Admin::IntrigueItemsController < Admin::BaseController
  before_filter :load_object, :only => [:show, :edit, :update]

  def index
    @intrigue_items = IntrigueItem.all
  end
  def new
    @intrigue_item = IntrigueItem.new
    @intrigue_item.build_address
  end
  def edit
    @intrigue_item.build_address if @intrigue_item.address.blank?
  end
  def show

  end


  def create
    @intrigue_item = IntrigueItem.new params[:intrigue_item]
    if @intrigue_item.save
      redirect_to admin_intrigue_item_url(@intrigue_item)
    else
      render :action => 'new'
    end
  end
  def update
    @intrigue_item.attributes = params[:intrigue_item]
    if @intrigue_item.save
      redirect_to admin_intrigue_item_url(@intrigue_item)
    else
      render :action => 'edit'
    end
  end
  protected
  def load_object
    @intrigue_item = IntrigueItem.find(params[:id])
  end
end
