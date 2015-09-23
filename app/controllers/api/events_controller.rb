class API::EventsController < ApplicationController
 
   #skip_before_action :verify_authenticity_token
   before_filter :set_access_control_headers

   respond_to :json 
 
   def create

     registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])

     if registered_application.nil?
      render json: "Unregistered application", status: :unprocessable_entity
     end

     @event = Event.new(event_params)

     if @event.save
       render json: @event, status: :created
       redirect_to @event
     else
       render @event.errors, status: :unprocessable_entity
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

   def set_access_control_headers
     headers['Access-Control-Allow-Origin'] = '*'
     headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
     headers['Access-Control-Allow-Headers'] = 'Content-Type'
   end



 end