require 'sinatra'
require 'sinatra/reloader'
require 'pry'
secret_number = rand(100)
guess = nil


get '/' do
  guess = params["guess"]
  local_message = check_guess(guess, secret_number)
  erb :index, locals: {number: secret_number, message: local_message}
end

def check_guess(guess_string, secret_number)
  guess = guess_string.to_i
  if guess == 0
    "Take a guess!"
  elsif guess > secret_number
    (guess - secret_number) > 5 ? "Way Too High" : "Too High"
  elsif guess < secret_number
    (secret_number - guess) > 5 ? "Way Too Low" : "Too Low"
    # binding.pry
  else
    "You win! The secret number is #{secret_number}"
  end
end
