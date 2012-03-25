class DashboardController < ApplicationController

before_filter :authenticate_user!

  def index
  	@regs = current_user.regs.all
  end
end
