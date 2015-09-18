class RegisteredAppsController < ApplicationController
  def index
    @registered_apps = RegisteredApp.all
  end

  def show
    @registered_app = RegisteredApp.find(params[:id])
  end

  def new
    @registered_app = RegisteredApp.new
    #authorize @registered_app
  end

  def create
    @registered_app = RegisteredApp.new(app_params)
    @registered_app.user = current_user

     if @registered_app.save
       flash[:notice] = "App was registered."
       redirect_to @registered_app
     else
       flash[:error] = "Error. Couuld not register the app."
     end

  end

  private

  def app_params
    params.require(:registered_app).permit(:name, :url)
  end

end
