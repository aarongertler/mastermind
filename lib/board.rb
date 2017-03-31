class Board
  def initialize(rows)
    @board = Array.new(rows) { Array.new(4,"____") }
    @rows = rows
  end

  def show
    @rows.times do |i|
      puts @board[i].inspect
    end
  end

  def rows
    @rows
  end

  def add_pegs(guess, code, turn)
    for i in 0..3
      if guess[i] = code[i]
        @board[turn][i] = code[i]
      elsif @code.include?(guess[i])
        @board[turn][i] = "white"
      end
    end
  end

end