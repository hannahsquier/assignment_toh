class TowersOfHanoi
  attr_reader :towers

  def initialize(towers=3)
    @towers = towers
  end
  
  #initialize board
  def set_up_board
    @board = Array.new(@towers, [])
    @board[0] = (1..@towers).to_a
  end

  #play!
  def play
    puts "Welcome to TOWERS OF HANOI. The goal of the game is to move all the disks 
      from the leftmost tower to the rightmost tower, adhering to the following 
      rules: Move only one disk at a time. A larger disk may not be placed ontop 
      of a smaller disk. To play, chose the tower (1 - #{@towers}) you would 
      like to move a piece from. Next, chose the tower (1 - #{@towers}) you would like to 
      move that disk to."
    set_up_board
    get_move
  end

  #ask player where she would like to move from and to
  def get_move
    display_board
    puts "Move FROM?"
    from = gets.chomp.to_i - 1

    puts "Move TO?"
    to = gets.chomp.to_i - 1

    if valid_move?(from, to)
      play_move(from, to)
    else
      puts "NOT VALID. Try again :)"
      get_move
    end
  end

  #define valid move
  def valid_move?(from, to)
    if from.between?(0, @towers) && to.between?(0, @towers) && from != to && 
      (@board[to].empty? || @board[from][0] < @board[to][0] )
      return true
    else
      return false
    end
  end

  #manipulate board to reflect player move choise
  def play_move(from, to)
    to_dup = @board[to].dup
    to_dup.unshift(@board[from][0]) 
    @board[to] = to_dup
    @board[from].shift
  
    
    if won?
      display_board
      puts "congratulations you won!"
    else
      get_move
    end
  end

  #Display the board so that it is easier to visualize
  def display_board
    display_board = Array.new(@towers)
    
    @board.each_with_index do |tower, i|
      display_board[i] = [" "] * (@towers - tower.length) + tower
    end
    
    puts "__________"
    puts "\nTOWERS OF HANOI\n"
    
    display_board.transpose.each do |row|
      puts " " + row.join("    ")
    end
    
    puts "---  " * @towers 
    puts " " + (1..@towers).to_a.join("    ")
    puts "\n\n"
  end

  #identify what winning means (all disks in order on last tower)
  def won?
    if @board.last == @board.last.sort && @board.last.length == @towers
      return true
    else
      return false
    end
  end
end


game = TowersOfHanoi.new(3)
game.play