class Board

  attr_reader :pegs
  attr_reader :rows

  def initialize(rows)
    @board = Array.new(rows) { Array.new(4,"____") }
    @pegs = Array.new(rows) { Array.new(4,"_") }
    @rows = rows
  end

  def show
    # Don't use "puts @board.show" in other parts of the code, or you'll just
    # puts the number of rows (extraneous)
    @rows.times do |i|
      puts ""
      puts @board[i].inspect
      puts @pegs[i].inspect
    end
  end

  def add_pegs(guess, pegs, row)
    # Just assigning @board[row] = guess was leaving all the board_rows as the
    # updated value of @guess -- could be fixed better later
    (0..3).each do |i|
      @board[row][i] = guess[i]
    end
    @pegs[row] = pegs
  end
end