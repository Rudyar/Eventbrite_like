class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  # before_filter :check_user, :only => [:show]

  def check_user
     @user = User.find(params[:id])
     unless current_user.id == @user.id
        redirect_to root_path
     end
  end

  def show
    check_user
    @user = User.find(params[:id])
    @events = Event.where(event_admin: @user)
  end
end