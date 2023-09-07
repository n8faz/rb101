require 'yaml'

MESSAGES = YAML.load_file('rock_paper_scissors_messages.yml')
MOVES = { 'rock' => { abbrev: 'r', beats: ['scissors', 'lizard'] },
          'paper' => { abbrev: 'p', beats: ['spock', 'rock'] },
          'scissors' => { abbrev: 'sc', beats: ['paper', 'lizard'] },
          'lizard' => { abbrev: 'l', beats: ['spock', 'paper'] },
          'spock' => { abbrev: 'sp', beats: ['scissors', 'rock'] } }
ROUNDS_TO_WIN = 3

# Methods that return

def clear_screen
  system "clear"
end

def arrow_prompt(message)
  puts "=> #{message}"
end

def valid_abbreviation
  MOVES.map { |_k, v| v[:abbrev] }
end

def valid_choice?(choice)
  MOVES.include?(choice)
end

def convert_abbreviation(choice)
  (MOVES.map { |k, v| k if v[:abbrev] == choice }).join
end

def win?(first, second)
  MOVES.dig(first, :beats).include?(second)
end

def get_computer_choice
  MOVES.keys.sample
end

def get_player_choice
  choice = nil
  loop do
    arrow_prompt(MESSAGES['choose'])
    choice = gets.chomp.downcase
    if valid_abbreviation.include?(choice)
      choice = convert_abbreviation(choice)
      break
    elsif valid_choice?(choice)
      break
    else
      arrow_prompt(MESSAGES['invalid_choice'])
    end
  end
  choice
end

def get_name
  name = nil
  loop do
    name = gets.chomp
    if name.empty? || name.start_with?
      arrow_prompt(MESSAGES['invalid_name'])
    else
      break
    end
  end
  name
end

def yes_or_no?(answer)
  if answer.downcase.start_with?('y')
    'yes'
  elsif answer.downcase.start_with?('n')
    'no'
  end
end

def play?
  answer = nil
  loop do
    arrow_prompt(MESSAGES['play?'])
    answer = gets.chomp
    answer = yes_or_no?(answer)
    break if answer == 'yes' || answer == 'no'
    arrow_prompt(MESSAGES['play_invalid'])
  end
  answer
end

def rematch
  arrow_prompt(MESSAGES['rematch'])
  sleep 2
end

def play_again?
  answer = nil
  loop do
    arrow_prompt(MESSAGES['again?'])
    answer = gets.chomp
    answer = yes_or_no?(answer)
    if answer == 'yes'
      rematch
      break
    elsif answer == 'no'
      break
    else
      arrow_prompt(MESSAGES['again_invalid'])
    end
  end
  answer
end

def next_round?
  answer = nil
  arrow_prompt(MESSAGES['next_round?'])
  loop do
    answer = gets.chomp
    if answer.downcase.start_with?('y')
      break
    elsif answer.downcase.start_with?('q')
      answer = 'quit'
      arrow_prompt(MESSAGES['quitting'])
      break
    else
      arrow_prompt(MESSAGES['wait'])
    end
  end
  answer
end

def game_over?(score)
  score[:player] == ROUNDS_TO_WIN || score[:computer] == ROUNDS_TO_WIN
end

def keep_score(choices, score)
  if win?(choices[:player], choices[:computer])
    score[:player] += 1
  elsif win?(choices[:computer], choices[:player])
    score[:computer] += 1
  end
  score
end

# Methods that print
def print_intro(name)
  arrow_prompt("Hi, #{name}!")
  puts
  arrow_prompt(MESSAGES['rules'])
  puts
  arrow_prompt(MESSAGES['rounds'] + "#{ROUNDS_TO_WIN} rounds is the Champion!")
  puts
  arrow_prompt(MESSAGES['opponent'])
  puts
end

def print_which_exit_message?(play, name)
  if play == 'no'
    arrow_prompt(MESSAGES['didnt_play'] + "#{name}.")
  else
    arrow_prompt(MESSAGES['thanks'] + "#{name}!")
  end
end

def print_start
  arrow_prompt(MESSAGES['start'])
  sleep 2
end

def print_round(round)
  clear_screen
  arrow_prompt(MESSAGES['line'] + " Round #{round} " + MESSAGES['line'])
end

def print_score(name, score)
  if game_over?(score)
    arrow_prompt(MESSAGES['final_score'])
  else
    arrow_prompt(MESSAGES['current_score'])
  end
  arrow_prompt("#{name}: " + score[:player].to_s)
  arrow_prompt(MESSAGES['computer_score'] + score[:computer].to_s)
end

def print_thinking
  arrow_prompt(MESSAGES['thinking'])
  sleep 2
  puts
end

def print_choices(choices)
  arrow_prompt(MESSAGES['you_chose'] + choices[:player].to_s.capitalize)
  arrow_prompt(MESSAGES['computer_chose'] + choices[:computer].to_s.capitalize)
  puts
end

def print_beats(first, second)
    arrow_prompt(("#{first.capitalize} beats " +
                  second.capitalize.to_s)) 
end

def print_results(choices)
  if win?(choices[:player], choices[:computer])
    print_beats(choices[:player], choices[:computer])
    arrow_prompt(MESSAGES['you_won_round'])
  elsif win?(choices[:computer], choices[:player])
    print_beats(choices[:computer], choices[:player])
    arrow_prompt(MESSAGES['computer_won_round'])
  else
    arrow_prompt(MESSAGES['tie'])
  end
  puts
end

def print_champion(name, score)
  if score[:player] == ROUNDS_TO_WIN
    arrow_prompt(MESSAGES['player_champion'])
    puts
    print_score(name, score)

  elsif score[:computer] == ROUNDS_TO_WIN
    arrow_prompt(MESSAGES['computer_champion'])
    puts
    print_score(name, score)
  end
end

def round_loop(name, score, current_round)
  loop do
    current_round += 1
    print_round(current_round)
    print_score(name, score)

    choices = { player: get_player_choice,
                computer: get_computer_choice }

    print_thinking
    print_choices(choices)
    print_results(choices)

    score = keep_score(choices, score)

    print_champion(name, score)
    break if game_over?(score) || next_round? == 'quit'
  end
end

# Program Start

clear_screen

arrow_prompt(MESSAGES['welcome'])
name = get_name
print_intro(name)

play = play?
if play == 'yes'
  print_start
  loop do # game loop
    score = { player: 0, computer: 0 }
    current_round = 0
    round_loop(name, score, current_round)
    puts
    break unless play_again? == 'yes'
  end
end

print_which_exit_message?(play, name)
