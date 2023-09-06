require 'yaml'

MESSAGES = YAML.load_file('rock_paper_scissors_messages.yml')
MOVES = { 'rock' => { abbrev: 'r', beats: ['scissors', 'lizard'] },
          'paper' => { abbrev: 'p', beats: ['spock', 'rock'] },
          'scissors' => { abbrev: 'sc', beats: ['paper', 'lizard'] },
          'lizard' => { abbrev: 'l', beats: ['spock', 'paper'] },
          'spock' => { abbrev: 'sp', beats: ['scissors', 'rock'] } }
ROUNDS_TO_WIN = 3

def clear_screen
  system "clear"
end

def messages(message)
  MESSAGES[message]
end

def arrow_prompt(message)
  puts "=> #{message}"
end

def no_arrow_prompt(message)
  puts message
end

def valid_abbreviation
  MOVES.map { |_k, v| v[:abbrev] }
end

def valid_choice?(choice)
  MOVES.include?(choice) || valid_abbreviation.include?(choice)
end

def convert_abbreviation(choice)
  (MOVES.map { |k, v| k if v[:abbrev] == choice }).join
end

def get_name
  name = nil
  loop do
    name = gets.chomp
    if name.empty? || name.start_with?(' ')
      arrow_prompt(messages('invalid_name'))
    else
      break
    end
  end
  name
end

def play?
  answer = nil
  loop do
    arrow_prompt(messages('play?'))
    answer = gets.chomp
    if answer.downcase.start_with?('y')
      answer = 'yes'
      break
    elsif answer.downcase.start_with?('n')
      answer = 'no'
      break
    else
      arrow_prompt(messages('play_invalid'))
    end
  end
  answer
end

def which_exit_message?(play, name)
  if play == 'no'
    arrow_prompt(messages('didnt_play') + "#{name}.")
  else
    arrow_prompt(messages('thanks') + "#{name}!")
  end
end

def print_start
  arrow_prompt(messages('start'))
  sleep 2
end

def print_round(round)
  clear_screen
  arrow_prompt(messages('line') + " Round #{round} " + messages('line'))
end

def print_score_tally(name, player_score, computer_score)
  arrow_prompt(messages('score'))
  arrow_prompt("#{name}: " + player_score.to_s)
  arrow_prompt(messages('computer_score') + computer_score.to_s)
end

def get_player_choice
  choice = nil
  loop do
    arrow_prompt(messages('choose'))
    choice = gets.chomp.downcase
    if choice.length < 3 && valid_abbreviation.include?(choice)
      choice = convert_abbreviation(choice)
      break
    elsif valid_choice?(choice)
      break
    else
      arrow_prompt(messages('invalid_choice'))
    end
  end
  choice
end

def get_computer_choice
  MOVES.keys.sample
end

def print_thinking
  arrow_prompt(messages('thinking'))
  sleep 2
  no_arrow_prompt(' ')
end

def print_choices(player_choice, computer_choice)
  arrow_prompt(messages('you_chose') + player_choice.to_s.capitalize)
  arrow_prompt(messages('computer_chose') + computer_choice.to_s.capitalize)
  no_arrow_prompt(' ')
end

def win?(first, second)
  MOVES.dig(first, :beats).include?(second)
end

def print_results(player, computer)
  if win?(player, computer)
    arrow_prompt("#{player.capitalize} beats #{computer.capitalize}")
    arrow_prompt(messages('you_won_round'))
  elsif win?(computer, player)
    arrow_prompt("#{computer.capitalize} beats #{player.capitalize}")
    arrow_prompt(messages('computer_won_round'))
  else
    arrow_prompt(messages('tie'))
  end
  no_arrow_prompt(' ')
end

def keep_score(player,
               computer,
               player_score,
               computer_score)
  if win?(player, computer)
    player_score += 1
  elsif win?(computer, player)
    computer_score += 1
  end
  [player_score, computer_score]
end

def next_round?
  answer = nil
  arrow_prompt(messages('next_round?'))
  loop do
    answer = gets.chomp
    if answer.downcase.start_with?('y')
      break
    elsif answer.downcase.start_with?('q')
      answer = 'quit'
      arrow_prompt(messages('quitting'))
      break
    else
      arrow_prompt(messages('wait'))
    end
  end
  answer
end

def game_over?(player_score, computer_score)
  if player_score == ROUNDS_TO_WIN
    arrow_prompt(messages('player_champion'))
    true
  elsif computer_score == ROUNDS_TO_WIN
    arrow_prompt(messages('computer_champion'))
    true
  else
    false
  end
end

def round_loop(name,
               player_score,
               computer_score,
               current_round)
  loop do
    current_round += 1
    print_round(current_round)
    print_score_tally(name, player_score, computer_score)

    player_choice = get_player_choice
    computer_choice = get_computer_choice

    print_thinking
    print_choices(player_choice, computer_choice)
    print_results(player_choice, computer_choice)

    player_score, computer_score = keep_score(player_choice,
                                              computer_choice,
                                              player_score,
                                              computer_score)
    break if game_over?(player_score, computer_score) || next_round? == 'quit'
  end
end

def play_again?
  answer = nil
  loop do
    arrow_prompt(messages('again?'))
    answer = gets.chomp
    if answer.downcase.start_with?('y')
      answer = 'yes'
      break
    elsif answer.downcase.start_with?('n')
      answer = 'no'
      break
    else
      arrow_prompt(messages('again_invalid'))
    end
  end
  answer
end

# Program Start

clear_screen

arrow_prompt(messages('welcome'))

name = get_name

info = <<-MSG
Hi, #{name}!

This game varies a bit from the traditional Rock, Paper, Scissors...

In the traditional game:

Rock crushes Scissors,
Scissors cuts Paper,
and Paper covers Rock.

In this game, you can also choose Lizard or Spock:

Rock crushes Lizard,
Lizard poisons Spock,
Spock smashes Scissors,
Scissors decapitates Lizard,
Lizard eats Paper,
Paper disproves Spock,
and Spock vaporizes Rock.

The game will be a best of 3. First to win 3 rounds is the Champion!

I, the Computer, will be your opponent. Don't worry, I won't cheat!

MSG

arrow_prompt(info)
play = play?

if play == 'yes'
  print_start

  loop do # game loop
    player_score = 0
    computer_score = 0
    current_round = 0
    round_loop(name,
               player_score,
               computer_score,
               current_round)
    no_arrow_prompt(' ')
    break unless play_again? == 'yes'
  end
end

which_exit_message?(play, name)
