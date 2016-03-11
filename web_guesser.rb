require 'sinatra'
require 'sinatra/reloader'
require 'pry'

# secret_number = rand(100)
secret_number = 20
guess = nil


get '/' do
  guess = params["guess"]
  local_message = check_guess(guess, secret_number)
  erb :index, locals: {number: secret_number, message: local_message, background: @background}
  end

  def check_guess(guess_string, secret_number)
    guess = guess_string.to_i
    if guess == 0
      "Take a guess!"
    elsif guess > secret_number
      if (guess - secret_number) > 5
        @background = "red"
        return "Way Too High"
        # bright red
      else
        @background = "rgb(233, 164, 164)"
        return "Too High"
        # light red
      end
    elsif guess < secret_number
      if (secret_number - guess) > 5
        @background = "red"
        return "Way Too Low"
        # bright red
      else
        @background = "rgb(233, 164, 164)"
        return "Too Low"
        # light red
        # binding.pry
      end
    else
      @background = "rgb(96, 242, 106)"
      return "You win! The secret number is #{secret_number}"
    end
  end
