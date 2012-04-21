class IntrigueItemsController < ApplicationController
  before_filter :load_object, :only => [:show]
  after_filter :mark_view, :only => [:show]

  def index
    @products = IntrigueItem.where(:interest => 'product').order_by(:view_count.desc, :name.asc).paginate(:page => page, :per_page => per_page)
    @people = IntrigueItem.where(:interest => 'person').order_by(:view_count.desc, :name.asc).paginate(:page => page, :per_page => per_page)
    @places = IntrigueItem.where(:interest => 'place').order_by(:view_count.desc, :name.asc).paginate(:page => page, :per_page => per_page)
  end

  def index_by_intrigue
    @intrigue = params[:intrigue]
    # Now, get the meta data applicable to ALL intrigue items for @intrigue
    begin
      @meta_data = MetaData.find(MetaData.map_ids_and_intrigues(@intrigue)['value']['ids'])
    rescue
      @meta_data = []
    end
    criteria = IntrigueItem.where(:interest => @intrigue)
    criteria = case sort_order
      when 'mv'
      criteria.order_by(:view_count.desc)
      when 'alpha'
      criteria.order_by(:name.asc)
      when 'hr'
      criteria.order_by(:cached_rating.desc)
      when 'meta'
      criteria.where(:meta_datum_ids.in => [params[:meta_data_id]]).order_by(:view_count.desc)
    end
    @intrigue_items = criteria.paginate(:page => page, :per_page => per_page)
  end

  def show
  end

  protected
  def load_object
    @intrigue_item = IntrigueItem.find(params[:id])
  end
  def mark_view
    @intrigue_item.viewed!
  end
  def per_page
    params[:per_page] || 10
  end
  def page
    params[:page] || 1
  end
  def sort_order
    params[:sort] || 'mv'
  end
end
