class Game
  include Helper

  def initialize(rows,choice)
    @turn = 0
    @guesser = Guesser.new
    @board = Board.new(rows)
    if choice == "1" 
      @role = :guesser
    elsif choice == "2"
      @role = :master
    else
      @role = :guesser
    end
    @master = Master.new(@role)
  end

  def play_game
    if @role == :guesser
      play_as_guesser
    else
      play_as_master
    end
  end

  def play_as_guesser
    @board.rows.times do
      @board.show
      guess_cycle
      victory_check
      @turn += 1
    end
    display_loss
  end

  def play_as_master # highly redundant with the above, shrink it down
    @board.rows.times do
      @board.show
      automated_guess_cycle
      victory_check
      @turn += 1
    end
    display_loss
  end

  def automated_guess_cycle
    @guess = @guesser.make_automated_guess(@board,@turn)
    @pegs = @master.check_guess(@guess)
    @board.add_pegs(@guess,@pegs,@turn)
  end

  def guess_cycle
    @master.ask_for_guess(@turn)
    @guess = @guesser.make_guess # Ugly redundancy here... how can we avoid running the check on the first iteration of our loop?
    until @master.valid_code?(@guess)
      @guess = @guesser.make_guess
    end
    @pegs = @master.check_guess(@guess)
    @board.add_pegs(@guess,@pegs,@turn)
  end

  def victory_check
    if @guess == @master.code
      puts "You win!"
      quit
    end
  end

  def display_loss
    @board.show
    puts "Sorry, you lost."
    puts "The real code was: #{@master.code}"
  end
end