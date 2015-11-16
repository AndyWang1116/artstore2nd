class Admin::UsersController < ApplicationController
 layout "admin"

 before_action :authenticate_user!
 before_action :admin_required

  def index
    @users = User.all
  end

  def to_admin                          # 定義 to_admin 這個 action
    @user = User.find(params[:user_id])
    @user.to_admin                      # @user使用to_admin這method,  定義在user.rb裡

    redirect_to admin_users_path
  end

  def to_normal                         # 定義 to_normal 這個 action
    @user = User.find(params[:user_id])
    @user.to_normal                     # @user使用to_normanl這method,  定義在user.rb裡

    redirect_to admin_users_path
  end
end
