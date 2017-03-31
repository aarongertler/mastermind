# Build a Mastermind game from the command line where you have 12 turns to guess the secret code, 
# starting with you guessing the computer's random code.

# Think about how you would set this problem up!
# Build the game assuming the computer randomly selects the secret colors and the human player 
# must guess them. Remember that you need to give the proper feedback on how good the guess was each turn!
# Now refactor your code to allow the human player to choose whether she wants to be the 
# creator of the secret code or the guesser.
# Build it out so that the computer will guess if you decide to choose your own secret colors. 
# Start by having the computer guess randomly (but keeping the ones that match exactly).
# Next, add a little bit more intelligence to the computer player so that, 
# if the computer has guessed the right color but the wrong position, 
# its next guess will need to include that color somewhere. Feel free to make the AI even smarter.

# Don't forget to require all your classes!



# Constants: List of colors (six total)

# Classes:

# Game (contains classes below, as well as a count of total guesses, a code variable, and a variable for whether the code
# is random or human-generated)
# Player (name, AI or human)
# Board (array of guesses, with white and black pegs for correct colors and correct color/positions)


# To-do:

# Let player choose the number of turns they're allowed?

# Dir['./lib/*'].each { |file_name| require file_name }

require './lib/game.rb'
require './lib/board.rb'
require './lib/player.rb'
require './lib/master.rb'
require './lib/guesser.rb'


Game.new(10).play_game