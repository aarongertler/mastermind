class Player
  COLOR_ARRAY = %w[red blue green yellow purple orange]

  private

  def generate_code
    code = []
    4.times do 
      code << COLOR_ARRAY[rand(0..5)]
    end
    code
  end

end