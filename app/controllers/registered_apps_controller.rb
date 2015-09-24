class RegisteredApplicationsController < ApplicationController
  def index
    @registered_applications = RegisteredApplication.all
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
    @event_count = @events.count
  end

  def new
    @registered_application = RegisteredApplication.new
    #authorize @registered_app
  end

  def create
    @registered_application = RegisteredApplication.new( registered_application_params )
    @registered_application.user = current_user

     if @registered_application.save
       flash[:notice] = "App was registered."
       redirect_to @registered_application
     else
       flash[:error] = "Error. Couuld not register the app."
     end

  end

  def update
     @registered_application = RegisteredApplication.find(params[:id])
     
     if @registered_application.update_attributes(app_params)
       flash[:notice] = "Updated the app."
       redirect_to @registered_application
     else
       flash[:error] = "Could not update app. Please try again."
       render :edit
     end
   end

   def destroy
     @registered_app = RegisteredApplication.find(params[:id])
 
     if @registered_application.destroy
       flash[:notice] = "\"#{@registered_app.name}\" has been deleted."
       redirect_to @registered_application
     else
       flash[:error] = "Could not delete the app."
       render :show
     end
   end


  private

  def registered_application_params
    params.require(:registered_application).permit(:name, :url)
  end

end
