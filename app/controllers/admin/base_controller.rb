class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @users = User.all
  end
  
  private

  def is_admin?
    unless current_user.is_admin
      redirect_to root_path, danger: "Nope !"
    end
  end

end