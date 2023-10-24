require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

get("/") do
  erb(:homepage)
end
