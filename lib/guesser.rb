class Guesser < Player
  include Helper

  def initialize
    @best_guess = [[],[]]
    @new_guess = [[],[]]
    @best_score = 0 
    @new_score = 0
    @change_index = 0
    @allowed_colors = COLOR_ARRAY
  end

  def make_guess
    gets.chomp.gsub(/[[:space:]]/, '').downcase.split(',')
  end

  def make_automated_guess(turn, board)
    if turn == 1 || @best_score < 1
      @new_guess = make_random_guess
    else
      @new_guess = make_smart_guess(@best_score)
    end
    @new_guess
  end

  def process_results(board, turn)
    new_result = board.pegs[turn] 
      # Had to reset index from "turn - 1" to "turn" when I moved results processing to after the new pegs were added
    new_score = set_score(new_result)
    puts "New guess: #{@new_guess}"
    puts "New score: #{new_score}"
    puts "Best score: #{@best_score}"
    set_best(@new_guess, new_result, new_score) if new_score > @best_score
    puts "Best guess: #{@best_guess}"
    ban_colors(@new_guess) if new_result == [] # Seems like we should need to not do this on turn 1, but that didn't wind up mattering
  end

  def ban_colors(guess) # Remove colors that we know don't appear in the code
    guess.each { 
      |color| @allowed_colors -= [color]
      puts "Now banning the color #{color}" }
  end

  def set_score(pegs)
    pegs.count('B') + (pegs.count('W') * 0.2) # Arbitrary scoring algorithm
  end

  def set_best(guess, result, score)
    puts "Setting a new best now! The last score was #{@best_score}"
    # return false if set_score(result) <= set_score(@best_guess[1])
    @best_guess[0] = guess # Store first part of best_guess array (the good guess)
    @best_guess[1] = result # Store second part of best_guess array (the peg count, W and B)
    @best_score = score
  end

  def make_random_guess
    guess = []
    4.times do
      guess << random_peg(@allowed_colors)
    end
    guess
  end

  def make_smart_guess(score)
    guess = @best_guess[0]  
      # Note: Setting a local variable to the value of an instance variable will change the instance variable later!
      # That's why index 0 of @best_guess changed, but not index 1
    change_count = (4 - score).floor  
      # The higher our score is, the fewer pegs we're going to change
      # This is still a stupid AI, but is at least working as planned
    change_guess(change_count, guess) # Make sure you return something here!
      # This is the line that was changing @best_guess before
  end

  def change_guess(count,guess) # Note: We now have an EXTREMELY CLUMSY way to dodge the instance variable issue -- make it less clumsy
    new_guess = []
    new_index = 0
    4.times do
      new_guess[new_index] = guess[new_index]
      new_index += 1
    end
    count.times do
      color = random_peg(@allowed_colors)
      new_guess[@change_index] = color
      if @change_index == 3
        @change_index = 0    # Reset change_index so next guess starts over with changing first peg
      else
        @change_index += 1
      end
    end
    new_guess
  end

  def return_best
    @best_guess
  end

  # The below was unnecessary -- we should only be choosing pegs from permitted colors in the first place

  # def remove_banned_colors(guess)
  #   guess.each_with_index do |color, index|
  #     guess[index] = random_peg(@allowed_colors) unless @allowed_colors.include?(color)
  #   end
  # end

end