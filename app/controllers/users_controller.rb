class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  rescue_from Pundit::NotAuthorizedError, with: :rescue_from_not_authorized

  def index
    @users = User.includes(:labels)
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def rescue_from_not_authorized
    redirect_to root_path, alert: 'Access denied.'
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
