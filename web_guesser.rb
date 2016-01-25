require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

def check_guess(guess)
  if guess == SECRET_NUMBER
    "You got it right!
    <br>
    <br>
    The SECRET NUMBER was #{SECRET_NUMBER}"
  elsif guess > (SECRET_NUMBER + 5)
    "WAY too high!"
  elsif guess > SECRET_NUMBER
    "Too high!"
  elsif guess < (SECRET_NUMBER - 5)
    "WAY too low!"
  elsif guess < SECRET_NUMBER
    "Too Low!"
  end
end

def color_options(guess)
  if guess == SECRET_NUMBER
    "Green"
  elsif guess > (SECRET_NUMBER + 5) || guess < (SECRET_NUMBER - 5)
    "Red"
  elsif guess > SECRET_NUMBER || guess < SECRET_NUMBER
    "Pink"
  else
    "White"
  end
end

def catching_cheaters
  "CHEATER!
  <br>
  <br>
  The SECRET NUMBER is #{SECRET_NUMBER}"
end


get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  message = catching_cheaters if params['cheat'] == 'true'
  background_color = color_options(guess)

  erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :background_color => background_color}
end
