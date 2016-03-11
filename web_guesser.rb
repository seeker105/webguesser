require 'sinatra'
require 'sinatra/reloader'
require 'pry'

@@secret_number = rand(100)
# @@secret_number = 20    #test data
guess = nil
@@number_of_guesses = 5


get '/' do
  guess = params["guess"]
  @cheat = params["cheat"] || false
  # binding.pry
  local_message = check_guess(guess, @@secret_number)
  erb :index, locals: {number: @@secret_number, message: local_message, background: @background}
  end

  def generate_number
    @@secret_number = rand(100)
    # @@secret_number = 20   #test data
  end

  def lose?
    if @@number_of_guesses == 0
      generate_number
      @@number_of_guesses = 5
      @background = "rgb(158, 103, 163)"   # purple
      result =  "\nYou lose. A new number has been generated"
    else
      result =  "\nRemaining guesses #{@@number_of_guesses}"
    end
    if @cheat
      result = result + "\nThe secret number is #{@@secret_number}"
    end
    result
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
      else
        @background = "rgb(233, 164, 164)" # light red
        @@number_of_guesses -= 1
        return "Too High\n#{lose?}"
      end
    elsif guess < @@secret_number
      if (@@secret_number - guess) > 5
        @background = "red"
        @@number_of_guesses -= 1
        return "Way Too Low\n#{lose?}"
        # bright red
      else
        @background = "rgb(233, 164, 164)"  # light red
        @@number_of_guesses -= 1
        return "Too Low\n#{lose?}"
      end
    else
      secret = @@secret_number
      generate_number
      @@number_of_guesses = 5
      @background = "rgb(96, 242, 106)"  # green
      return "\nYou win! The secret number is #{secret}"
    end
  end
