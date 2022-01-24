=begin
Tic Tac Toe

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. If neither winner nor board is full, go to #2.
8. Play again?
9. If yes, go to #1.
10. Goodbye!

=end

require 'pry'
require 'pry-byebug'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

ROUNDS_TO_WIN = 5

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd, scores)
  system 'clear'
  puts "You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts "Scores: Player #{scores[:player]}, Computer #{scores[:computer]}"
  puts "First to #{ROUNDS_TO_WIN} rounds wins."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

# Return list of empty squares.
def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, delimiter = ', ', word = 'or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{last_item_separator} ")
  else
    arr[...-1].join(delimiter) + "#{delimiter}#{word} #{arr.last}"
  end
end

def place_piece!(board, current_player)
  if current_player == 'player'
    player_places_piece!(board)
  else
    computer_places_piece!(board)
  end
end

def alternate_player(current_player)
  current_player == 'player' ? 'computer' : 'player'
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = find_winning_square(brd)
  square = find_at_risk_square(brd) unless square
  square = 5 if !square && brd[5] == INITIAL_MARKER
  square = empty_squares(brd).sample unless square
  brd[square] = COMPUTER_MARKER
end

def find_at_risk_square(brd)
  square = nil
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
       brd.values_at(*line).count(INITIAL_MARKER) == 1
      square = line.select { |sq| brd[sq] == INITIAL_MARKER }.first
      break
    end
  end
  square
end

def find_winning_square(brd)
  square = nil
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
       brd.values_at(*line).count(INITIAL_MARKER) == 1
      square = line.select { |sq| brd[sq] == INITIAL_MARKER }.first
      break
    end
  end
  square
end

def choose_first_player
  prompt "Who goes first? 1) Player, 2) Computer, 3) Let Computer choose."
  choice = ''
  loop do
    choice = gets.chomp.to_i
    break if [1, 2, 3].include? choice
    prompt "Invalid choice. Enter 1, 2, or 3."
  end

  case choice
  when 1
    'player'
  when 2
    'computer'
  when 3
    computer_choice = ['player', 'computer'].sample
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).all?(PLAYER_MARKER)
      return 'Player'
    elsif brd.values_at(*line).all?(COMPUTER_MARKER)
      return 'Computer'
    end
  end
  nil
end

# Loop for game
loop do
  scores = { player: 0, computer: 0 }

  # Loop for round
  loop do
    board = initialize_board
    current_player = choose_first_player

    loop do
      display_board(board, scores)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board, scores)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won this round!"
      if detect_winner(board) == 'Player'
        scores[:player] += 1
      else
        scores[:computer] += 1
      end
    else
      prompt "It's a tie!"
    end

    if scores[:player] == ROUNDS_TO_WIN
      prompt 'Player won the game!'
      break
    elsif scores[:computer] == ROUNDS_TO_WIN
      prompt 'Computer won the game!'
      break
    else
      prompt 'Press Enter to start the next round.'
      gets
    end
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic-Tac-Toe. Goodbye!"
