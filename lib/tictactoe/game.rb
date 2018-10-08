module TicTacToe
  class Game
   
    def initialize
      @board = [[nil, nil, nil],
               [nil, nil, nil],
               [nil, nil, nil]]
               
      @players = [:X, :O].cycle
    end
    
    attr_reader :board, :players, :current_player
    
    def play
      start_new_turn

      loop do
        display_board

        row, col = move_input
        next unless valid_move?(row, col)
        
        board[row][col] = current_player
        
        if winning_move?(row, col)
          puts "#{current_player} wins!"
          return
        end

        if draw?
          puts "It's a draw!"
          return
        end

        start_new_turn
      end
    end


    # Make next move
    def start_new_turn
      @current_player = @players.next
    end

    # Display the updated board after every move
    def display_board
      puts board.map { |row| row.map { |e| e || " " }.join("|") }.join("\n")
    end

    # Taking the user input
    def move_input
      print "\n>> "
      row, col = gets.split.map { |e| e.to_i }
      puts

      [row, col]
    end

    # Check if move is valid
    def valid_move?(row, col)
      begin
        cell_contents = board.fetch(row).fetch(col)
      rescue IndexError
        puts "Out of bounds, try another position"
        return false
      end

      if cell_contents
        puts "Cell occupied, try another position"
        return false
      end

      true
    end

    # Check if move entered wins the game
    def winning_move?(row, col)
      left_diagonal = [[0,0], [1,1], [2,2]]
      right_diagonal = [[0,2], [1,1], [2,0]]

      lines = []
      
      [left_diagonal, right_diagonal].each do |line|
        lines << line if line.include?([row, col])
      end

      lines << (0..2).map { |i| [row, i] }
      lines << (0..2).map { |i| [i, col] }

      lines.any? do |line|
        line.all? { |row, col| board[row][col] == current_player }
      end
    end

    # Check if match is a tie
    def draw?
      board.flatten.compact.length == 9
    end


  end
end         