module TestAPIHelper
  
  def json( body )
    JSON.parse( body, symbolize_names: true )
  end
  
end