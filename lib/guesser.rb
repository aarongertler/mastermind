class Guesser < Player
  include Helper

  def initialize
    @best_guess = [[],[]]
    @last_guess = []
    @best_score = 0
    @change_index = 0
    @allowed_colors = COLOR_ARRAY
  end

  def make_guess
    return gets.chomp.gsub(/[[:space:]]/, '').downcase.split(',')
  end

  def make_automated_guess(board,turn)
    last_result = board.pegs[turn - 1]
    set_best(@last_guess,last_result)
    if last_result == [] && turn != 1
      ban_colors(@last_guess)
    end
    @new_guess = smart_guess
    @last_guess = @new_guess
    @new_guess
  end

  def ban_colors(guess)
    guess.each { |color| @allowed_colors -= [color] }
  end

  def set_score(pegs)
    pegs.count("B") + (pegs.count("W") * 0.2)
  end

  def set_best(guess,result)
    if set_score(result) > set_score(@best_guess[1])
      @best_guess[0] = guess
      @best_guess[1] = result
    end
  end

  def random_guess
    guess = []
    4.times do
      guess << random_peg(@allowed_colors)
    end
    guess
  end

  def smart_guess
    current_score = set_score(@best_guess[1])
    puts "Best guess: #{@best_guess}"
    puts "Current score: #{current_score}"
    if current_score < 1
      guess = random_guess
    else
      guess = improved_guess(current_score)
    end
    guess
  end

  def improved_guess(current_score)
    guess = @best_guess[0]
    # The higher our score is, the fewer pegs we're going to change
    # This is still a very stupid AI, but is at least working well enough that it can be improved later
    change_count = (4 - current_score).floor
    remove_banned_colors(change_guess(change_count,guess))
  end

  def change_guess(count,guess)
    count.times do
      color = random_peg(@allowed_colors)
      guess[@change_index] = color
      if @change_index == 3
        @change_index = 0
      else
        @change_index += 1
      end
    end
    guess
  end

  def remove_banned_colors(guess)
    guess.each_with_index do |color, index|
      if !@allowed_colors.include?(color)
        guess[index] = random_peg(@allowed_colors)
      end
    end
  end

end


# Left off at figuring out what was going on with @last_guess






