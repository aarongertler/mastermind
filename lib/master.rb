class Master < Player
  def initialize
    @code = generate_code
  end

  def code  # We shouldn't have to write a separate method to get this, right?
    @code
  end

  def ask_for_guess(turn)
    good_formatting = false
    puts "This is turn #{turn}."
    puts "What is your guess? (Enter your answer as four comma-separated colors. Order matters!)"
    puts "Available colors are: (#{COLOR_ARRAY})"
    until good_formatting == true
      guess = gets.chomp.downcase.split(',')
      if !guess.size == 4
        puts "Please enter an array of four colors."
      else
        good_formatting = true
      end
    end
    guess
  end
end
