CHOICES = {
  rock:     { abbreviation: 'r',  defeats: ['lizard', 'scissors'] },
  paper:    { abbreviation: 'p',  defeats: ['rock', 'spock'] },
  scissors: { abbreviation: 'sc', defeats: ['paper', 'lizard'] },
  lizard:   { abbreviation: 'l',  defeats: ['spock', 'paper'] },
  spock:    { abbreviation: 'sp', defeats: ['scissors', 'rock'] }
}

SCORE_TO_WIN = 3

rules = <<-RULES
        Scissors cuts Paper
        Paper covers Rock
        Rock crushes Lizard
        Lizard poisons Spock
        Spock smashes Scissors
        Scissors decapitates Lizard
        Lizard eats Paper
        Paper disproves Spock
        Spock vaporizes Rock
        Rock crushes Scissors
RULES

def prompt(message)
  puts "=> #{message}"
end

# Hash to lookup full name from abbreviation
# Format: { 'r' => 'rock', 'p' => 'paper',... }
def create_abbreviation_hash
  abbreviation_hash = Hash.new

  CHOICES.each do |choice, data|
    abbreviation = data[:abbreviation]
    abbreviation_hash[abbreviation] = choice.to_s
  end

  abbreviation_hash
end

def query_player_choice
  player_choice = ''

  loop do
    prompt "Choose one by typing:"
    CHOICES.each do |choice, data|
      prompt "#{data[:abbreviation]} or #{choice.to_s}"
    end

    player_choice = gets.chomp.downcase.strip

    choice_abbreviation_hash = create_abbreviation_hash

    # Input validation
    # Full name received
    if CHOICES.key? player_choice.to_sym
      return player_choice.to_sym
    # Abbreviation received
    elsif choice_abbreviation_hash.key? player_choice
      return choice_abbreviation_hash[player_choice].to_sym
    else
      prompt("That's not a valid choice.")
    end
  end
end

def win?(first, second)
  CHOICES[first.to_sym][:defeats].include? second.to_s
end

def calc_winner(player, computer)
  if player == computer
    "tie"
  elsif win?(player, computer)
    "player"
  else
    "computer"
  end
end  

def calc_game_winner(scores)
  scores[:player] == SCORE_TO_WIN ? 'player' : 'computer'
end 

def display_result(winner)
  case winner
    when 'player' then prompt 'You won this round!'
    when 'computer' then prompt 'Computer won this round!'
    else prompt "It's a tie!"
    end
end
  
def update_score(scores, winner)
  case winner
    when 'player' then scores[:player] += 1
    when 'computer' then scores[:computer] += 1
    end
end

def display_scores(scores)
  puts "-------------------------------------------------"
  prompt "Score: Player #{scores[:player]}, Computer #{scores[:computer]}"
  puts "-------------------------------------------------"
end

def game_over?(scores)
  scores[:player] == SCORE_TO_WIN || scores[:computer] == SCORE_TO_WIN
end

def display_winner_congratulations(winner)
  prompt winner == 'player' ? 'You won the game!' : 'Computer won the game.'
end

def display_winner(winner)
  prompt player_score > computer_score ? 'You won!' : 'You lost...'
end

def play_again?
  loop do
    prompt 'Do you want to play again (yes or no)?'
    answer = gets.chomp.downcase.strip
    if %[y yes].include? answer
      break true
    elsif %[n no].include? answer
      break false
    else
      prompt 'Please enter a valid input.'
    end
  end
end

system "clear"

prompt 'Welcome to Rock Paper Scissors Lizard Spock!'
prompt 'The rules are:'
puts rules
prompt 'First to a score of 3 wins.'

loop do
  scores = { player: 0, computer: 0 }
  
  loop do
    display_scores(scores)

    player_choice = query_player_choice()
    computer_choice = CHOICES.keys.sample

    puts "You chose: #{player_choice}. Computer chose: #{computer_choice}."

    winner = calc_winner(player_choice, computer_choice)
    display_result(winner)
    update_score(scores, winner)
    
    if game_over?(scores)
      display_scores(scores)
      game_winner = calc_game_winner(scores)
      display_winner_congratulations(winner)
      break
    end
  end

  if play_again?
    system 'clear'
  else
    break
  end
end

prompt "Thank you for playing. Goodbye!"
