class Game
  def initialize
    @turn = 0
    @guess = []
    @master = Master.new
    @guesser = Guesser.new
    @board = Board.new
    @code = generate_code

    play_game
  end

  def generate_code
    code = []
    color_array = %w[red,blue,green,yellow,purple,orange]
    4.times.do 
      code << color_array[rand(1..6)]
    end
  end

  def ask_for_guess
    puts "What is your guess? (Enter your answer as four comma-separated colors. Order matters!)"
    puts "Available colors are: (#{color_array})"
    @guess = gets.chomp.downcase.split(',')
  end

  def process_guess
    for i in 0..3
      if @guess[i] = @code[i]
        @board[i] = @code[i]
      elsif @code.include?(@guess[i])
        @board[i] = "white"
      end
    end
  end

  def report_result
    puts "Here's the result:"
    @board.show
  end

  def play_game
    while @turn < 12 && victory == false
      puts @board
      ask_for_guess
      process_guess
      report_result
    end

    if @turn == 12
      puts "Sorry, you lost"
    else
      puts "You're a winner!"
    end
  end

end