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
    puts "Welcome to TOWERS OF HANOI. The goal of the game is to move all the 
    disks from the leftmost tower to the rightmost tower, adhering to the 
    following rules: Move only one disk at a time. A larger disk may not be 
    placed ontop of a smaller disk. To play, chose the tower (1 - #{@towers}) 
    you would like to move a piece from. Next, chose the tower (1 - #{@towers}) 
    you would like to move that disk to. 'quit' will quit the program at any 
    time. Enjoy! :)"

    set_up_board
    get_move
  end

  #ask player where she would like to move from and to
  def get_move
    render
    puts "Move FROM?"
    from = gets.chomp
    
    # quit program if player types quit
    exit if from.downcase == "quit"

    from = from.to_i - 1 #convert user input into usable integer index
  
    puts "Move TO?"
    to = gets.chomp
    
    # quit program if player types quit
    exit if to.downcase == "quit"
    
    to = to.to_i - 1 #convert user input into usable integer index

    if valid_move?(from, to)
      play_move(from, to)
    
    else
      puts "\n\n__________"
      puts "\nNOT VALID. Try again :)"
      get_move
    end
  end

  #define valid move
  def valid_move?(from, to)

    #choices are between tower 1 and total number of towers
    if !from.between?(0, @towers) && !to.between?(0, @towers) 
      return false

    #to and from choice are different from each other
    elsif from == to 
      return false

    #from choice is not nil
    elsif @board[from][0].nil? 
      return false

    #if to choice is nil, move is valid
    elsif @board[to][0].nil?
      return true

    #return false if from choice is greater than to choice
    elsif @board[from][0] > @board[to][0]
      return false

    else
      return true
    end
  end

  #manipulate board to reflect player move choise
  def play_move(from, to)
    #create duplicate of board, to correct pass by reference error
    #add top disk on from tower to the top of to tower
    to_dup = @board[to].dup
    to_dup.unshift(@board[from][0]) 
    @board[to] = to_dup
    @board[from].shift
  
    if won?
      render
      puts "congratulations you won!\n\n"
    else
      get_move
    end
  end

  #Display the board so that it is easier to visualize
  def render
    render = Array.new(@towers)
    
    @board.each_with_index do |tower, i|
      render[i] = [" "] * (@towers - tower.length) + tower
    end
    
    puts "__________"
    puts "\nTOWERS OF HANOI\n"
    
    render.transpose.each do |row|
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


game = TowersOfHanoi.new(8)
game.play