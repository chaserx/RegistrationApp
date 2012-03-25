class SuperuserController < ApplicationController
	before_filter :authenticate_user!
  	before_filter :authorized?

  def index
  	@superusers = User.where(admin: true).all
  	@users = User.where(admin: false).all
  end

  protected
  def authorized?
      redirect_to user_root_url unless current_user.admin?
  end

end
