class Game
  include Helper

  def initialize(rows, choice)
    @turn = 0
    @guesser = Guesser.new
    @board = Board.new(rows)
    @role = :guesser if choice == '1'
    @role = :master if choice == '2'
    @role ||= :guesser
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
      automated_guess_cycle
      @board.show
      victory_check
      @turn += 1
    end
    display_loss
  end

  def automated_guess_cycle
    @guess = @guesser.make_automated_guess(@board, @turn)
    @pegs = @master.check_guess(@guess)
    @board.add_pegs(@guess, @pegs, @turn)
    @guesser.process_results(@board, @turn)
  end

  def guess_cycle
    @master.ask_for_guess(@turn)
    @guess = @guesser.make_guess until @master.valid_code?(@guess)
    @pegs = @master.check_guess(@guess)
    @board.add_pegs(@guess, @pegs, @turn)
  end

  def victory_check
    return false if @guess != @master.code # guard clauses! Hooray!
    puts "You win! The final code was: #{@guess}"
    quit
  end

  def display_loss
    puts 'Sorry, you lost.'
    puts "Your best guess was: #{@guesser.return_best}"
    puts "The real code was: #{@master.code}"
  end
end