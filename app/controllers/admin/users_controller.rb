class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all   
  end

  def show
    @user = User.find(params[:id])
    @events = Event.where(event_admin: @user)
  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, success: "Profil édité avec succès"
    else
      render :edit, alert: "Impossible d'éditer le profil :"
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to admin_users_path, success: "Profil supprimé avec succès"

  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :profile_picture)
  end

end
