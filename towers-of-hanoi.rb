class TowersOfHanoi
  attr_reader :towers

  def initialize(towers=3)
    @towers = towers
  end
 
  def set_up_board
    @board = Array.new(@towers, [])
    @board[0] = (1..@towers).to_a
  end

  def play
    set_up_board
    get_move
  end

  def get_move
    display_board
    puts "Which tower would you like to move the top disk from?"
    from = gets.chomp.to_i - 1

    puts "Which tower would you like to move that piece to? #{(1..@towers).to_a.delete(from)}"
    to = gets.chomp.to_i - 1

    if valid_move?(from, to)
      play_move(from, to)
    else
      puts "That is not a valid choice, please chose a tower between 1 and #{@towers}. Remember no larger piece can go on a smaller piece."
      get_move
    end
  end

  def valid_move?(from, to)
    if from.between?(0, @towers) && to.between?(0, @towers) && from != to && (@board[to].empty? || @board[from][0] < @board[to][0] )
      return true
    else
      return false
    end
  end

  def play_move(from, to)
    to_dup = @board[to].dup
    to_dup.unshift(@board[from][0]) 
    @board[to] = to_dup
    @board[from].shift
  
    
    if won?
      puts "congratulations you won!"
    else
      get_move
    end
  end

  # def display_board
  #   display_board = Array.new(@towers)
    
  #   @board.each_with_index do |tower, i|
  #     display_board[i] = [" "] * (@towers - tower.length) + tower
  #   end

  #   display_board.transpose.each { |row| puts row }
    
  # end

  def won?
    if @board.any? { |tower| tower == tower.sort && tower.length == @towers}
      return true
    else
      return false
    end
  end
end


game = TowersOfHanoi.new(3)
game.play