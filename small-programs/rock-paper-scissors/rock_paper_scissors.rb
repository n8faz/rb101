require 'yaml'

MESSAGES = YAML.load_file('rock_paper_scissors_messages.yml')
VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
VALID_ABBREVIATIONS = { 'r' => 'rock',
                        'p' => 'paper',
                        'sc' => 'scissors',
                        'l' => 'lizard',
                        'sp' => 'spock' }
WIN_CONDITIONS = { 'rock' => ['scissors', 'lizard'],
                   'paper' => ['rock', 'spock'],
                   'scissors' => ['paper', 'lizard'],
                   'lizard' => ['paper', 'spock'],
                   'spock' => ['scissors', 'rock'] }

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

def abbreviation(user_choice)
  VALID_ABBREVIATIONS[user_choice]
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
  clear_screen
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
    if VALID_CHOICES.include?(choice)
      break
    elsif VALID_ABBREVIATIONS.include?(choice)
      choice = abbreviation(choice)
      break
    else
      arrow_prompt(messages('invalid_choice'))
    end
  end
  choice
end

def get_computer_choice
  VALID_CHOICES.sample
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
  WIN_CONDITIONS[first].include?(second)
end

def display_results(player, computer)
  if win?(player, computer)
    arrow_prompt(messages('you_won_round'))
  elsif win?(computer, player)
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
  arrow_prompt(messages('next_round?'))
  loop do
    answer = gets.chomp
    break if answer.downcase.start_with?('y')
    arrow_prompt(messages('wait'))
  end
  #clear_screen
end

def game_over?(player_score, computer_score)
  if player_score == 3
    arrow_prompt(messages('player_champion'))
    no_arrow_prompt(' ')
    true
  elsif computer_score == 3
    arrow_prompt(messages('computer_champion'))
    no_arrow_prompt(' ')
    true
  else
    false
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

play = nil
loop do # main loop
  arrow_prompt(info)
  play = play?
  break if play == 'no'

  print_start

  loop do # game loop
    player_score = 0
    computer_score = 0
    current_round = 0
    loop do # round loop
      current_round += 1
      print_round(current_round)
      print_score_tally(name, player_score, computer_score)

      player_choice = get_player_choice
      computer_choice = get_computer_choice

      print_thinking
      print_choices(player_choice, computer_choice)
      display_results(player_choice, computer_choice)

      player_score, computer_score = keep_score(player_choice,
                                                computer_choice,
                                                player_score,
                                                computer_score)
      break if game_over?(player_score, computer_score)
      next_round?
    end
  break unless play_again? == 'yes'
  end
end

which_exit_message?(play, name)
