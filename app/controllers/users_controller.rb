class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page], per_page: 10) 
  end

  def show
    @user = User.find(params[:id])
    @apps = @user.registered_applications
  end

  def new
  end
end
