class Admin::CategoriesController < Admin::BaseController
  before_filter :load_object, :only => [:show, :edit, :update]

  def index
    @categories = Category.all
  end
  def new
    @category = Category.new

  end
  def edit

  end
  def show

  end


  def create
    @category = Category.new params[:category]
    @category.save
    redirect_to admin_category_url(@category)
  end
  def update
    @category.attributes = params[:category]
    @category.save
    redirect_to admin_category_url(@category)
  end
  protected
  def load_object
    @category = Category.find(params[:id])
  end
end
