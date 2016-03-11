require 'sinatra'
require 'sinatra/reloader'
require 'pry'

# @@secret_number = rand(100)
@@secret_number = 20
guess = nil
@@number_of_guesses = 5


get '/' do
  guess = params["guess"]
  local_message = check_guess(guess, @@secret_number)
  erb :index, locals: {number: @@secret_number, message: local_message, background: @background}
  end

  def generate_number
    @@secret_number = # rand(100)
    @@secret_number = 20
  end

  def lose?
    if @@number_of_guesses == 0
      generate_number
      @@number_of_guesses = 5
      @background = "rgb(158, 103, 163)"
      return "You lose. A new number has been generated"
    else
      return "Remaining guesses #{@@number_of_guesses}"
    end

  end

  def check_guess(guess_string, secret_number)
    guess = guess_string.to_i
    if guess == 0
      "Take a guess!"
    elsif guess > @@secret_number
      if (guess - @@secret_number) > 5
        @background = "red"
        @@number_of_guesses -= 1
        return "Way Too High\n#{lose?}"
        # bright red
      else
        @background = "rgb(233, 164, 164)"
        @@number_of_guesses -= 1
        return "Too High\n#{lose?}"
        # light red
      end
    elsif guess < @@secret_number
      if (@@secret_number - guess) > 5
        @background = "red"
        @@number_of_guesses -= 1
        return "Way Too Low\n#{lose?}"
        # bright red
      else
        @background = "rgb(233, 164, 164)"
        @@number_of_guesses -= 1
        return "Too Low\n#{lose?}"
        # light red
        # binding.pry
      end
    else
      secret = @@secret_number
      generate_number
      @@number_of_guesses = 5
      @background = "rgb(96, 242, 106)"
      return "You win! The secret number is #{secret}"
    end
  end
