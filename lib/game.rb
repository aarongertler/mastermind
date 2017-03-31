class Game
  def initialize(rows)
    @turn = 0
    @guess = []
    @master = Master.new
    @guesser = Guesser.new
    @board = Board.new(rows)
  end

  def report_result
    puts "You now have X colored pegs and Y white pegs." # Replace with counts from the board
    puts "You now have #{@board.rows - @turn} turns left to break the code."
  end

  def play_game
    while @turn <= @board.rows && @board != @code
      puts @board.show
      @guess = @master.ask_for_guess(@turn)
      @board.add_pegs(@guess,@master.code,@turn)
      report_result
      @turn += 1
    end

    if @turn > @board.rows
      puts "Sorry, you lost."
      puts "The real code was: #{@code}"
    else
      puts "You're a winner!"
    end
  end

end