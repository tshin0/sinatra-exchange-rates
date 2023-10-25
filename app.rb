require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  @api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  @raw_response = HTTP.get(@api_url).to_s
  
  @parsed_response = JSON.parse(@raw_response)
  
  @currency_hash = @parsed_response.fetch("currencies")
  @currency = @currency_hash.keys 
  
  erb(:homepage)
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")
  @api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  @raw_response = HTTP.get(@api_url).to_s
  
  @parsed_response = JSON.parse(@raw_response)
  
  @currency_hash = @parsed_response.fetch("currencies")
  @currency = @currency_hash.keys 
  
  
  
  erb(:from_currency)

end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")
  @api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  @raw_response = HTTP.get(@api_url).to_s
  
  @parsed_response = JSON.parse(@raw_response)

  @rate = @parsed_response.fetch("result")


  erb(:to_currency)



end
