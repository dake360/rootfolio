class ProfilesController < ApplicationController
  before_filter :load_profile, :only => [:show]
  before_filter :load_own_profile, :only => [:edit, :update]

  def edit

  end

  def update
    @profile.attributes = params[:profile]
    @profile.save
    flash[:notice] = "Your profile was successfully updated."
    redirect_to profile_path(@user)
  end

  protected
  def load_profile
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def load_own_profile
    @user = current_user
    @profile = @user.profile || @user.build_profile
  end
end
