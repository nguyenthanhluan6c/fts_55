class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = @users.page params[:page]
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params      
      flash[:success] = t "user.updated"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy  
    if @user.destroy      
      flash[:success] = t "user.deleted"      
    else
      flash[:danger] = t "user.can_not_delete"     
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :role
  end
end
