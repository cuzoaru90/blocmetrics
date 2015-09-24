require 'test_helper'

module API

  class UserCreatesEventTest < ActionDispatch::IntegrationTest    
    test "should create test successfully" do
      registered_application = registered_applications(:valid)
      
      assert_difference( 'Event.count' ) do
        post '/api/events', 
          { event:
            { name: 'foobar' }
          }.to_json,
          { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s, "Origin": registered_application.url }
      end
      
      assert_equal 201, response.status
      assert_equal Mime::JSON, response.content_type
    end
  
    test "should not create an event with invalid URL" do
      registered_application_url = ''
      
      assert_no_difference( 'Event.count' ) do
        post '/api/events', 
          { event:
            { name: 'foobar' }
          }.to_json,
          { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s, "Origin": registered_application_url }
      end
        
      assert_equal 422, response.status
      assert_equal Mime::JSON, response.content_type
      
      error_response = json( response.body )
      assert_equal( { error: "missing valid registered application URL" }, error_response )
    end
    
    test "should not create an event with missing event name" do
      registered_application = registered_applications( :valid )
      
      assert_no_difference( 'Event.count' ) do
        post '/api/events', 
          { event:
            { name: nil }
          }.to_json,
          { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s, "Origin": registered_application.url }
      end
        
      assert_equal 422, response.status
      assert_equal Mime::JSON, response.content_type
      
      error_response = json( response.body )
      assert_equal( { error: "missing event name" }, error_response )
    end
  end

end
