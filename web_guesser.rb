require 'sinatra'
require 'sinatra/reloader'


get '/' do
  "The secret NUMBER is #{secret_number}"
end

def secret_number
  rand(100)
end
