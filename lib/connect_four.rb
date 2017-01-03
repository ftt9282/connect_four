class Slot
  attr_accessor :color
  def initialize
    @color = 'o'
  end
end

class Board
  attr_accessor :board
  def initialize
    @board = generate_board
  end

  def generate_board
    empty_board = Array.new(6){Array.new(7)}
    empty_board.each_with_index do |x, xi|
      x.each_with_index do |y, yi|
        empty_board[xi][yi] = Slot.new
      end
    end
    empty_board
  end

  def show_board
    @board.each_with_index do |x, xi|
      x.each_with_index do |y, yi|
        print "#{@board[xi][yi].color}  "
      end
      print "\n"
    end
    print"-------------------\n"
    print"0  1  2  3  4  5  6\n"
  end

  def update_board(column, player_color)
  	x_count = 5
    until @board[x_count][column].color == 'o'
      x_count -= 1
    end
    @board[x_count][column].color = player_color
    four_in_a_row?("#{x_count}#{column}", player_color)
  end

  def four_in_a_row?(data, player_color)
    x, y = data.split('').map(&:to_i)
    winner = check_horizonal(x, y, player_color) || check_vertical(x, y, player_color) || check_diagonal_right(x, y, player_color) || check_diagonal_left(x, y, player_color)
    winner
  end

  def check_horizonal(x, y, player_color)
    count = 1
    left, right = 1, 1
    until y - left < 0 || @board[x][y-left].color != player_color
      count += 1
      left += 1  
    end
    until y + right > 6 || @board[x][y+right].color != player_color
      count += 1
      right += 1  
    end
    count >= 4 ? true : false
  end

  def check_vertical(x, y, player_color)
    count = 1
    up, down = 1, 1
    until x + down > 5 || @board[x+down][y].color != player_color
      count += 1
      down += 1  
    end
    until x - up < 0 || @board[x-up][y].color != player_color
      count += 1
      up += 1  
    end
    count >= 4 ? true : false
  end

  def check_diagonal_right(x, y, player_color)
    count = 1
    up, right, down, left = 1, 1, 1, 1
    until y + right > 6 || x - up < 0 || @board[x-up][y+right].color != player_color
      count += 1
      up += 1
      right += 1  
    end
    until y - left < 0 || x + down > 5 || @board[x+down][y-left].color != player_color
      count += 1
      down += 1
      left += 1  
    end
    count >= 4 ? true : false
  end

  def check_diagonal_left(x, y, player_color)
    count = 1
    up, right, down, left = 1, 1, 1, 1
    until y + right > 6 || x + down > 5 || @board[x+down][y+right].color != player_color
      count += 1
      down += 1
      right += 1  
    end
    until y - left < 0 || x - up < 0 || @board[x-up][y-left].color != player_color
      count += 1
      up += 1
      left += 1  
    end
    count >= 4 ? true : false
  end
end

class Player
  @@player_count = 1
  attr_reader :name, :color
  def initialize(name)
    @name = name
    @@player_count == 1 ? @color = "R" : @color = "Y"
    @@player_count += 1
  end
end

class Gameplay
  attr_reader :gameboard
  def initialize
    @gameboard = Board.new
  end

  def start_game
    puts "Hello and welcome to Connect 4! Let's begin."
    player1 = create_new_player
    player2 = create_new_player
    move_count = 0
    winner = false
    until winner || move_count == 42
      move_count += 1
      if move_count % 2 == 1
      	winner = make_move(player1)
      else 
      	winner = make_move(player2)
      end
    end
    if move_count == 42
    	tie_game
    else
    	move_count % 2 == 1 ? game_won(player1) : game_won(player2)
    end
  end

  def create_new_player
    puts "What is your name?"
    return Player.new(gets.chomp)
  end

  def make_move(player)
    @gameboard.show_board
    puts "#{player.name}, choose which column you'd like to put your piece in"
    column = gets.chomp.to_i
    @gameboard.update_board(column, player.color)
  end

  def tie_game
  	@gameboard.show_board
    puts "Tie"
    exit
  end

  def game_won(player)
  	@gameboard.show_board
    puts "Winner!!!"
    exit
  end
end

connect_four = Gameplay.new
connect_four.start_game