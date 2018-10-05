=begin

board = [[nil, nil, nil],
         [nil, nil, nil],
         [nil, nil, nil]]
         
players = [:X, :O].cycle

loop do
  current_player = players.next
  puts board.map { |row| row.map{ |e| e || " " }.join("|") }.join("\n")
  print "\n>> "
  row, col = gets.split.map {|e| e.to_i}
  puts
  board[row][col] = current_player
end         

=end

board = [[nil, nil, nil],
         [nil, nil, nil],
         [nil, nil, nil]]
         
players = [:X, :O].cycle

left_diagonal = [[0,0], [1,1], [2,2]]
right_diagonal = [[0,2], [1,1], [2,0]]

current_player = players.next

loop do
  puts board.map {|row| row.map { |e| e || " "}.join("|")}.join("\n")
  print "\n>> "
  row, col = gets.split.map { |e| e.to_i }
  puts
  begin
    cell_contents = board.fetch(row).fetch(col)
  rescue IndexError
    puts "Out of bounds, try again"
    next
  end
  
  if cell_contents
    puts "Cell occupied, please try another position"
    next
  end
  
  board[row][col] = current_player
  
  lines = []
  
  [left_diagonal, right_diagonal].each do |line|
    lines << line if line.include?([row, col])
  end
  
  p lines
  
  
  lines << (0..2).map { |c1| [row, c1] }
  p lines
  
  lines << (0..2).map { |r1| [r1, col] }
  p lines
  
  win = lines.any? do |line|
    line.all? { |row, col| board[row][col] == current_player }
  end
  
  if win
    puts "#{current_player} wins!"
    exit
  end
  
  if board.flatten.compact.length == 9
    puts "It's a draw"
    exit
  end
  
  current_player = players.next
end         