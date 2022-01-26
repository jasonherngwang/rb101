# Twenty-One Game

# Constants
GAME_LIMIT = 21
DEALER_LIMIT = 17

SUITS = %w(H D C S)
SUIT_SYMBOLS = { 'H' => "\u2665", 'D' => "\u2666",
                 'C' => "\u2663", 'S' => "\u2660",
                 '?' => '?' }
RANKS = [*('2'..'10'), 'J', 'Q', 'K', 'A']
CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10,
                'K' => 10, 'A' => 1 }

MESSAGES = {
  welcome: "Welcome to Twenty-One.",
  rules: "The greater hand value wins, but you bust if you go over 21!",
  goodbye: "Thank you for playing Twenty-One. Goodbye!",
  continue: "Press Enter to continue.",
  player_turn: "It's your turn.",
  query_player_action: "Hit or Stay? (h/hit or s/stay)",
  player_busted: "You busted!",
  player_won: "You won!",
  dealer_turn: "It's the dealer's turn.",
  dealer_stay: "Dealer chose to stay.",
  dealer_hit: "Dealer chose to hit.",
  dealer_busted: "Dealer busted!",
  dealer_won: "Dealer won!",
  tie: "It's a tie.",
  game_over: "Game over.",
  final_hands: "Final hands:",
  play_again: "Want to play again? (y/yes or n/no)",
  invalid_input: "Please enter a valid input.",
  separator_line: '-' * 80
}

# Display Methods

def prompt(msg)
  puts "=> #{msg}"
end

def display_welcome
  prompt MESSAGES[:welcome]
  prompt MESSAGES[:rules]
  prompt MESSAGES[:continue]
  gets
end

def display_hand(cards, hand_value = nil)
  card_strings = cards.map { |card| "#{SUIT_SYMBOLS[card[0]]}#{card[1]}" }
  puts card_strings.join(', ')
  if hand_value
    puts "Total: #{hand_value}"
  end
end

def display_hands(cards, hand_values, reveal_dealer: true)
  print 'Dealer has: '
  if reveal_dealer
    display_hand(cards[:dealer], hand_values[:dealer])
  else
    display_hand([cards[:dealer][0], ['?', '?']])
  end

  print 'You have:   '
  display_hand(cards[:player], hand_values[:player])
end

# Deck and Card Methods

def initialize_deck
  SUITS.product(RANKS).shuffle
end

def draw_card!(player, cards, hand_values)
  cards[player] << cards[:deck].pop
  hand_values[player] = calc_hand_value(cards[player])
end

# Player and Dealer Turn Methods

def player_turn(cards, hand_values)
  prompt MESSAGES[:player_turn]
  loop do
    action = query_player_action
    break if action == :stay
    draw_card!(:player, cards, hand_values)
    display_hands(cards, hand_values, reveal_dealer: false)
    break if busted?(hand_values[:player])
  end
end

def query_player_action
  answer = ''
  loop do
    prompt MESSAGES[:query_player_action]
    answer = gets.chomp.downcase
    puts
    return :stay if %w(s stay).include? answer
    return :hit if %w(h hit).include? answer
    prompt MESSAGES[:invalid_input]
  end
end

def dealer_turn(cards, hand_values)
  prompt MESSAGES[:dealer_turn]
  loop do
    sleep 0.5
    if hand_values[:dealer] >= DEALER_LIMIT
      prompt MESSAGES[:dealer_stay]
      puts
      break
    end
    prompt MESSAGES[:dealer_hit]
    puts
    draw_card!(:dealer, cards, hand_values)
    display_hands(cards, hand_values)
    break if busted?(hand_values[:dealer])
  end
end

# Calculation Methods

def calc_hand_value(hand)
  hand_sum = hand.reduce(0) do |sum, card|
    sum + CARD_VALUES[card[1]]
  end

  if (hand_sum <= 11) && (hand.any? { |card| card[1] == 'A' })
    hand_sum + 10
  else
    hand_sum
  end
end

def busted?(hand_value)
  hand_value > GAME_LIMIT
end

def detect_result(hand_values)
  player_total = hand_values[:player]
  dealer_total = hand_values[:dealer]

  if busted?(player_total)
    :player_busted
  elsif busted?(dealer_total)
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

# End-of-game Methods

def display_game_result(cards, hand_values)
  prompt MESSAGES[:game_over]

  game_result = detect_result(hand_values)
  case game_result
  when :player_busted then prompt MESSAGES[:player_busted]
  when :dealer_busted then prompt MESSAGES[:dealer_busted]
  when :player        then prompt MESSAGES[:player_won]
  when :dealer        then prompt MESSAGES[:dealer_won]
  when :tie           then prompt MESSAGES[:tie]
  end

  prompt MESSAGES[:final_hands]
  display_hands(cards, hand_values, reveal_dealer: true)
end

def play_again?
  answer = ''
  loop do
    prompt MESSAGES[:play_again]
    answer = gets.chomp.downcase
    return true if %w(n no).include? answer
    return false if %(y yes).include? answer
    prompt MESSAGES[:invalid_input]
  end
end

# Main Game Loop
system 'clear'
display_welcome

loop do
  system 'clear'
  cards = {
    deck: initialize_deck,
    player: [],
    dealer: []
  }

  hand_values = {
    player: 0,
    dealer: 0
  }

  2.times do
    draw_card!(:player, cards, hand_values)
    draw_card!(:dealer, cards, hand_values)
  end

  display_hands(cards, hand_values, reveal_dealer: false)

  player_turn(cards, hand_values)

  if hand_values[:player] > hand_values[:dealer] &&
     !busted?(hand_values[:player])
    dealer_turn(cards, hand_values)
  end

  display_game_result(cards, hand_values)
  puts

  break if play_again?
end

prompt MESSAGES[:goodbye]
