class Admin::MetaDataController < Admin::BaseController
  before_filter :load_object, :only => [:show, :edit, :update]
  def index
    @meta_data = MetaData.all
  end

  def new
    @meta_datum = MetaData.new
  end
  def edit
  end

  def show
  end

  def create
    @meta_datum = MetaData.new params[:meta_data]
    if @meta_datum.save
      redirect_to admin_meta_datum_path(@meta_datum)
    else
      render :action => 'new'
    end
  end

  def update
    @meta_datum.attributes = params[:meta_data]
    if @meta_datum.save
      redirect_to admin_meta_datum_path(@meta_datum)
    else
      render :action => 'new'
    end
  end

  protected

  def load_object
    @meta_datum = MetaData.find(params[:id])
  end
end
