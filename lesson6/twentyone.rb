# Twenty-One Game

# Constants
# ------------------------------------------------------------------------------

GAME_LIMIT = 21
SUITS = %w(H D C S)
SUIT_SYMBOLS = { 'H' => "\u2665", 'D' => "\u2666",
                 'C' => "\u2663", 'S' => "\u2660" }
RANKS = [*('2'..'10'), 'J', 'Q', 'K', 'A']
CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10,
                'K' => 10, 'A' => 1 }

MESSAGES = {
  welcome: "Welcome to Twenty-One.",
  rules: "The greater hand value wins, but you bust if you go over 21!",
  goodbye: "Thank you for playing Twenty-One. Goodbye!",
  player_turn: "It's your turn.",
  query_player_action: "Hit or Stay? (h/hit or s/stay)",
  player_stay: "You chose to stay.",
  player_hit: "You chose to hit.",
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

# Helper Methods
# ------------------------------------------------------------------------------

# Display Methods

def prompt(msg)
  puts "=> #{msg}"
end

def display_welcome
  prompt MESSAGES[:welcome]
  prompt MESSAGES[:rules]
end

def display_goodbye
  prompt MESSAGES[:goodbye]
end

# Combine card suit symbol and rank into a single string, for display.
def format_card(card)
  "#{SUIT_SYMBOLS[card[0]]}#{card[1]}"
end

def display_hands(cards, hand_values, reveal_dealer: false)
  player_hand = cards[:player].map { |card| format_card(card) }
  dealer_hand = cards[:dealer].map { |card| format_card(card) }

  puts MESSAGES[:separator_line]

  if reveal_dealer
    prompt "Dealer has: #{dealer_hand.join(', ')}. "\
           "Total: #{hand_values[:dealer]}"
  else
    prompt "Dealer has: #{dealer_hand[0]} + #{dealer_hand.length - 1} more."
  end
  prompt "You have: #{player_hand.join(', ')}. "\
         "Total: #{hand_values[:player]}"

  puts MESSAGES[:separator_line]
end

# Setup Deck

def initialize_deck
  SUITS.product(RANKS).shuffle
end

# Player and Dealer Turns

def player_turn(cards, hand_values)
  prompt MESSAGES[:player_turn]

  loop do
    action = query_player_action
    if action == :stay
      prompt MESSAGES[:player_stay]
      break
    else
      prompt MESSAGES[:player_hit]
      cards[:player] << cards[:deck].pop
      hand_values[:player] = calc_hand_value(cards[:player])
      display_hands(cards, hand_values)
      break if busted?(hand_values[:player])
    end
  end
end

# Ask player to choose hit or stay.
def query_player_action
  answer = ''
  loop do
    prompt MESSAGES[:query_player_action]
    answer = gets.chomp.downcase
    return :stay if %w(s stay).include? answer
    return :hit if %w(h hit).include? answer
    prompt MESSAGES[:invalid_input]
  end
end

def dealer_turn(cards, hand_values)
  puts
  prompt MESSAGES[:dealer_turn]

  loop do
    sleep 0.5
    if hand_values[:dealer] >= 17
      prompt MESSAGES[:dealer_stay]
      break
    end
    prompt MESSAGES[:dealer_hit]
    cards[:dealer] << cards[:deck].pop
    hand_values[:dealer] = calc_hand_value(cards[:dealer])
    display_hands(cards, hand_values)
    break if busted?(hand_values[:dealer])
  end
end

# Calculations

def calc_hand_value(hand)
  hand_sum = hand.reduce(0) do |sum, card|
    sum + CARD_VALUES[card[1]]
  end

  # Check if one ace can be 11 without busting.
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

# End-of-game methods
def display_game_result(cards, hand_values)
  puts
  prompt MESSAGES[:game_over]

  game_result = detect_result(hand_values)
  case game_result
  when :player_busted
    prompt MESSAGES[:player_busted]
  when :dealer_busted
    prompt MESSAGES[:dealer_busted]
  when :player
    prompt MESSAGES[:player_won]
  when :dealer
    prompt MESSAGES[:dealer_won]
  when :tie
    prompt MESSAGES[:tie]
  end

  prompt MESSAGES[:final_hands]
  display_hands(cards, hand_values, reveal_dealer: true)
  puts
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

# Game Execution
# ------------------------------------------------------------------------------

# Main Game Loop
loop do
  system 'clear'
  display_welcome

  # Initialize deck and player hands.
  cards = {
    deck: initialize_deck,
    player: [],
    dealer: []
  }

  2.times do
    cards[:player] << cards[:deck].pop
    cards[:dealer] << cards[:deck].pop
  end

  hand_values = {
    player: calc_hand_value(cards[:player]),
    dealer: calc_hand_value(cards[:dealer])
  }

  display_hands(cards, hand_values)

  # Player Turn
  player_turn(cards, hand_values)

  # Dealer takes turn if player is winning and has not busted.
  if hand_values[:player] > hand_values[:dealer] &&
     !busted?(hand_values[:player])
    dealer_turn(cards, hand_values)
  end

  display_game_result(cards, hand_values)
  break if play_again?
end

prompt MESSAGES[:goodbye]
