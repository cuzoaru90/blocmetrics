class API::EventsController < ApplicationController
 
   skip_before_action :verify_authenticity_token

   respond_to :json  
 
   def create
     registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
    
     if registered_application.nil?
       render json: { error: "missing valid registered application URL" }, status: :unprocessable_entity
     else
       @event = registered_application.events.build( event_params )  
       
       if @event.save
         render json: @event, status: :created
       else
         render json: { error: "missing event name" }, status: :unprocessable_entity
       end
     end
   end

private

   def permission_denied_error
     error(403, 'Permission Denied!')
   end

   def error(status, message = 'Something went wrong')
    response = {
      response_type: "ERROR",
      message: message
    }

    render json: response.to_json, status: status
   end

   def event_params
     params.require(:event).permit(:name)
   end

end
