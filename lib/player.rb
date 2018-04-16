class Player
  COLOR_ARRAY = %w[red blue green yellow purple orange].freeze

  private

  # Should this be in Guesser or Player?
  def random_peg(*allowed_colors)
      allowed_colors[0][rand(0...allowed_colors[0].size)]
  end

  def generate_code
    code = []
    4.times do 
      code << random_peg(COLOR_ARRAY)
    end
    code
  end

  def enter_code
    code = []
    4.times do |i|
      choice = ""
      while !COLOR_ARRAY.include?(choice)
        puts "Choose color ##{i + 1} for your code. \\
        (Must be one of the following: #{COLOR_ARRAY}.)"
        choice = gets.chomp.downcase
        if !COLOR_ARRAY.include?(choice)
          puts "Please choose a color from among the options."
        end
      end
      code << choice
    end
    code
  end
end