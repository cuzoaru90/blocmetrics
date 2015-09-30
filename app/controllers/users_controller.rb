class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :admin?

  def index
    @users = User.paginate(page: params[:page], per_page: 10) 
  end

  def show
    @user = User.find(params[:id])
    @apps = @user.registered_applications
  end


  private

  def admin?
    if current_user.role != 'admin'
      flash[:notice] = "This page is restricted to the admin."
      redirect_to welcome_index_path
    end
  end

end
