# Twenty-One Game

# Constants
GAME_LIMIT = 21
DEALER_LIMIT = 17

SUITS = {
  'Heart':   "\u2665",
  'Diamond': "\u2666",
  'Club':    "\u2663",
  'Spade':   "\u2660",
}
RANKS = [*('2'..'10'), 'J', 'Q', 'K', 'A']
CARD_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                '8' => 8, '9' => 9, '10' => 10, 'J' => 10, 'Q' => 10,
                'K' => 10, 'A' => 1 }

MESSAGES = {
  welcome: "Welcome to Twenty-One!",
  rules: <<~RULES,
    Rules of the Game:
    - You and the dealer will each be dealt 2 cards.
    - You play first, and then the dealer will play.
    - You can choose to hit (draw) or stay (don't draw).
    - The hand value is the sum of all card values. Aces can be worth 1 or 11. 
    - A player busts and loses the game if their hand value exceeds 21.
    - The greater hand value wins if neither player busts.
  RULES
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

def display_hand(hand, hand_value = nil)
  card_strings = hand.map { |card| "#{SUITS[card[:suit]]}#{card[:rank]}" }
  card_strings << '??' if hand.length == 1
  puts card_strings.join(', ')
  if hand_value
    puts "Total: #{hand_value}"
  end
end

def display_hands(player_data, reveal_dealer: true)
  print 'Dealer has: '
  if reveal_dealer
    display_hand(player_data[:dealer][:hand], player_data[:dealer][:hand_value])
  else
    display_hand([player_data[:dealer][:hand][0]])
  end

  print 'You have:   '
  display_hand(player_data[:player][:hand], player_data[:player][:hand_value])
end

# Deck and Card Methods

def initialize_deck
  SUITS.keys.product(RANKS).shuffle.map do |suit, rank|
    { suit: suit, rank: rank }
  end
end

def draw_card!(player, deck, player_data)
  player_data[player][:hand] << deck.pop
  player_data[player][:hand_value] = calc_hand_value(player_data[player][:hand])
end

# Player and Dealer Turn Methods

def player_turn(deck, player_data)
  prompt MESSAGES[:player_turn]
  loop do
    action = query_player_action
    break if action == :stay
    draw_card!(:player, deck, player_data)
    display_hands(player_data, reveal_dealer: false)
    break if busted?(player_data[:player][:hand_value])
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

def dealer_turn(deck, player_data)
  prompt MESSAGES[:dealer_turn]
  loop do
    sleep 0.5
    if player_data[:dealer][:hand_value] >= DEALER_LIMIT
      prompt MESSAGES[:dealer_stay]
      puts
      break
    end
    prompt MESSAGES[:dealer_hit]
    puts
    draw_card!(:dealer, deck, player_data)
    display_hands(player_data)
    break if busted?(player_data[:dealer][:hand_value])
  end
end

# Calculation Methods

def calc_hand_value(hand)
  hand_sum = hand.reduce(0) do |sum, card|
    sum + CARD_VALUES[card[:rank]]
  end

  hand_sum = correct_for_aces(hand, hand_sum)
end

def correct_for_aces(hand, hand_sum)
  if (hand_sum <= 11) && (hand.any? { |card| card[1] == 'A' })
    hand_sum + 10
  else
    hand_sum
  end
end

def busted?(hand_value)
  hand_value > GAME_LIMIT
end

def detect_result(player_data)
  player_total = player_data[:player][:hand_value]
  dealer_total = player_data[:dealer][:hand_value]

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

def display_game_result(player_data)
  prompt MESSAGES[:game_over]

  game_result = detect_result(player_data)
  case game_result
  when :player_busted then prompt MESSAGES[:player_busted]
  when :dealer_busted then prompt MESSAGES[:dealer_busted]
  when :player        then prompt MESSAGES[:player_won]
  when :dealer        then prompt MESSAGES[:dealer_won]
  when :tie           then prompt MESSAGES[:tie]
  end

  prompt MESSAGES[:final_hands]
  display_hands(player_data, reveal_dealer: true)
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
  deck = initialize_deck

  player_data = {
    player: { hand: [], hand_value: 0 },
    dealer: { hand: [], hand_value: 0 }
  }

  2.times do
    draw_card!(:player, deck, player_data)
    draw_card!(:dealer, deck, player_data)
  end

  display_hands(player_data, reveal_dealer: false)

  player_turn(deck, player_data)

  if player_data[:player][:hand_value] > player_data[:dealer][:hand_value] &&
     !busted?(player_data[:player][:hand_value])
    dealer_turn(deck, player_data)
  end

  display_game_result(player_data)
  puts

  break if play_again?
end

prompt MESSAGES[:goodbye]
