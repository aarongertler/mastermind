class Player
  COLOR_ARRAY = %w[red blue green yellow purple orange]

  private

  # Technically, this probably shouldn't be attached to Player anymore, but is Guesser actually better?
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
      puts "Choose color ##{i + 1} for your code. (Must be one of the following: #{COLOR_ARRAY}.)"
      code << gets.chomp.downcase
    end
    code
  end

end