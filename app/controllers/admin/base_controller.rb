class Admin::BaseController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  layout 'admin'


  protected
  def require_admin
    redirect_to '/' unless current_user
    redirect_to '/' unless current_user.is_admin?
  end
end
