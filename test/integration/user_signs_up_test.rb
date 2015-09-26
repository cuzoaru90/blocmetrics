require 'test_helper'

class UserSignsUpTest < ActionDispatch::IntegrationTest

  test "As a user, I want to sign up for a free account by providing a name, password, and email" do
    visit root_path

    click_link 'Sign Up'

    fill_in 'Name', with: Faker::Name.name
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'user_password', with: '12345678'
    fill_in 'user_password_confirmation', with: '12345678'

    click_button 'Sign Up'
    
    assert page.has_content?( 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.' ) 
  end

end
