module TestAPIHelpers
  
  def json
    JSON.parse( response.body, symbolize_names: true )
  end
  
end

RSpec.configure do |c|
  c.include TestAPIHelpers
end
