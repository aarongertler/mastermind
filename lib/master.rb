class Master < Player
  include Helper

  attr_reader :code
  
  def initialize(role)
    if role == :guesser
      @code = generate_code
    else
      @code = choose_code
    end
  end

  def choose_code
    code = enter_code
    if valid_code?(code)
      code
    else
      puts "Please choose four comma-separated colors."
      choose_code
    end
  end

  def ask_for_guess(turn)
    puts "This is turn #{turn + 1}."
    puts "What is your guess? (Enter your answer as four comma-separated colors. Order matters!)"
    puts "Available colors are: (#{COLOR_ARRAY})"
    puts "If you don't want to guess, enter \"quit\" to quit the game."
  end

  def valid_code?(guess)
    return false if guess == nil
    quit if guess == ["quit"]
    if guess.size != 4
      puts "Please enter an array of four colors."
      false
    elsif guess.any? { |x| !COLOR_ARRAY.include?(x)}
      puts "Please enter only the colors shown."
      false
    else
      true
    end
  end

  def check_guess(guess)
    @hint = []
    check_for_whites(check_for_blacks(guess))
  end

# Wound up rewriting this whole section because I wasn't getting the rules right:
# [red, red, red, red] *should* return three white pegs if any red is present

  def check_for_blacks(guess)
    @guess_minus_blacks = []
    guess.each_with_index do |color, index|
      if @code[index] == color
        @hint << 'B'
      else
        @guess_minus_blacks << guess[index]
      end
    end
    @guess_minus_blacks
  end

  def check_for_whites(guess)
    guess.each do |peg|
      @hint << 'W' if @code.any? { |color| color == peg }
    end
    @hint
  end

end
