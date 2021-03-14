class Game
  attr_accessor :next_move, :gamestate, :turn_count, :input

  def initialize
    p "Here is an empty tic-tac-toe board:"
    puts ""
    reset
    puts ""
    p "In order to select a move, choose a number from 1 to 9 corresponding to a position on the board as follows:"
    puts ""
    @example = [
      ["1","|","2","|","3",""],
      ["4","|","5","|","6",""],
      ["7","|","8","|","9",""]
    ]
    @example.each do |line|
      puts line.join
    end
    puts ""
  end

  def reset
    @gamestate = [
      ["-","|","-","|","-",""],
      ["-","|","-","|","-",""],
      ["-","|","-","|","-",""]
    ]
    print_gamestate
    @turn_player = "X"
    @next_move = false
    @winner = false
    @turn_count = 0
    @moves = [1,2,3,4,5,6,7,8,9]
  end

  def print_gamestate
    @gamestate.each do |line|
      puts line.join
    end
    puts ""
  end

  def advance_gamestate
    @gamestate[@next_move[0]][@next_move[1]] = @turn_player

    print_gamestate
    if victory_check
      p "Player '#{@turn_player}' wins!"
    end

    if @turn_player == "X"
      @turn_player = "O"
    else
      @turn_player = "X"
    end

    @next_move = false
    @turn_count += 1
  end

  def player_input
    p "Player '#{@turn_player}': please select your next move"
    @input = gets.chomp
    puts ""
    puts ""
  end

  def computer_input
    @input = @moves.sample
    @moves.delete(@input)
  end

  def calculate_next_move
    if @input.to_i == 1 && @gamestate[0][0] == "-"
      @next_move = [0, 0]
    elsif @input.to_i == 2 && @gamestate[0][2] == "-"
      @next_move = [0, 2]
    elsif @input.to_i == 3 && @gamestate[0][4] == "-"
      @next_move = [0, 4]
    elsif @input.to_i == 4 && @gamestate[1][0] == "-"
      @next_move = [1, 0]
    elsif @input.to_i == 5 && @gamestate[1][2] == "-"
      @next_move = [1, 2]
    elsif @input.to_i == 6 && @gamestate[1][4] == "-"
      @next_move = [1, 4]
    elsif @input.to_i == 7 && @gamestate[2][0] == "-"
      @next_move = [2, 0]
    elsif @input.to_i == 8 && @gamestate[2][2] == "-"
      @next_move = [2, 2]
    elsif @input.to_i == 9 && @gamestate[2][4] == "-"
      @next_move = [2, 4]
    elsif @input.downcase == "state"
      print_gamestate
    else
      p "invalid input"
    end
  end

  def play_game
    print_gamestate

    while turn_count < 9 && @winner == false
      while next_move == false
        #for testing purposes: to make the program automatically play the game with random choices, comment out "player_input" and comment in "computer input"

        player_input
        #computer_input
        calculate_next_move
      end
      advance_gamestate
    end

    unless @winner == true
      p "The game has ended in a draw"
    end
  end

  def victory_check
    if (
      @gamestate[@next_move[0]][@next_move[1]] == @turn_player && @gamestate[@next_move[0] - 1][@next_move[1]] == @turn_player && @gamestate[@next_move[0] - 2][@next_move[1]] == @turn_player
    ) || (
      @gamestate[@next_move[0]][@next_move[1]] == @turn_player && @gamestate[@next_move[0]][@next_move[1] - 2] == @turn_player && @gamestate[@next_move[0]][@next_move[1] - 4] == @turn_player
    ) || (
      @gamestate[0][0] == @turn_player && 
       @gamestate[1][2] == @turn_player && 
       @gamestate[2][4] == @turn_player
    ) || (
       @gamestate[2][0] == @turn_player && 
       @gamestate[1][2] == @turn_player && 
       @gamestate[0][4] == @turn_player
    )
      @winner = true
    end
    return @winner
  end
end

#10000.times do
game = Game.new
game.play_game
#end