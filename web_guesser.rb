require 'sinatra'
require 'sinatra/reloader'
require 'pry'

@@secret_number = rand(100)
guess = nil
@@number_of_guesses = 5


get '/' do
  guess = params["guess"]
  @@cheat = params["cheat"] || false
  local_message = check_guess(guess)
  erb :index, locals: {number: @@secret_number, message: local_message, background: @background}
end

def generate_number
  @@secret_number = rand(100)
end

def lose
    generate_number
    @@number_of_guesses = 5
    @background = "rgb(158, 103, 163)"   # purple
    "<br>You lose. A new number has been generated"
end

def check_magnitude_of_difference(guess)
  if (guess-@@secret_number).abs > 5
    @background = "red"
    "Way "
  else
    @background = "rgb(233, 164, 164)" # light red
    ""
  end
end

def check_cheat_mode
  if @@cheat
    "<br>The secret number is #{@@secret_number}"
  else
    ""
  end
end

def generate_additional_messages(guess, result)
  result = result + "<br>Remaining guesses #{@@number_of_guesses}"
  @@number_of_guesses -= 1
  result = result.insert(0, check_magnitude_of_difference(guess))
  result = result + check_cheat_mode
end

def check_guess(guess_string)
  guess = guess_string.to_i
  if guess == @@secret_number
    win
  elsif @@number_of_guesses == 0
    lose
  elsif guess == 0
    "Take a guess!"
  elsif guess > @@secret_number
    message = "Too High<br>Take a guess!"
    generate_additional_messages(guess, message)
  else  # guess < @@secret_number
    message = "Too Low<br>Take a guess!"
    generate_additional_messages(guess, message)
  end
end

def win
    secret = @@secret_number
    generate_number
    @@number_of_guesses = 5
    @background = "rgb(96, 242, 106)"  # green
    return "<br>You win! The secret number is #{secret}"
end
