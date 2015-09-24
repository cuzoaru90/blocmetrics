require 'rails_helper'

module API

  RSpec.describe EventsController, type: :controller do
  
    it "should create test successfully" do
      registered_application = create(:registered_application)
    
      expect {  
        post :create, 
        { event:
          { name: 'foobar' }
        }.to_json,
        { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s, "Origin": registered_application.url }
      }.to change(Event, :count).by(1)
    
      expect( response.status ).to eq( 201 )
      expect( response.status ).to eq( Mime::JSON )
    end
  
    it "should not create an event with invalid URL" do
      registered_application = create(:registered_allication, url: nil)
    
      expect {  
        post :create, 
        { event:
          { name: 'foobar' }
        }.to_json,
        { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s, "Origin": registered_application.url }
      }.to change(Event, :count).by(0)
    
      expect( response.status ).to eq( 422 )
      expect( response.status ).to eq( Mime::JSON )
    
      error_response = json( response.body )
      expect( error_response ).to eq( { error: "missing valid registered application URL" } )
    end
  
    it "should not create an event with missing event name" do
      registered_application = create(:registered_application)
        
      expect {  
        post :create, 
        { event:
          { name: nil }
        }.to_json,
        { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s, "Origin": registered_application.url }
      }.to change(Event, :count).by(0)
      
      expect( response.status ).to eq( 422 )
      expect( response.status ).to eq( Mime::JSON )
        
      error_response = json( response.body )
      expect( error_response ).to eq( { error: "missing event name" } )
    end

  end

end
