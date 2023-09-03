require 'yaml'

MESSAGES = YAML.load_file('rock_paper_scissors_messages.yml')
VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
VALID_ABBREVIATIONS = {'r' => 'rock',
                       'p' => 'paper', 
                       'sc' => 'scissors', 
                       'l' => 'lizard', 
                       'sp' => 'spock'
                      }
WIN_CONDITIONS = {'rock' => ['scissors', 'lizard'],
                  'paper' => ['rock', 'spock'],
                  'scissors' => ['paper', 'lizard'],
                  'lizard' => ['paper', 'spock'],
                  'spock' => ['scissors', 'rock']
                 }

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
  sleep 1
  clear_screen
end

def print_round(round)
  arrow_prompt("Round #{round}")
end

def print_score_tally(player_score, computer_score)
  arrow_prompt(messages('score'))
  arrow_prompt(messages('your_score') + player_score.to_s)
  arrow_prompt(messages('computer_score') + computer_score.to_s)
end

def get_user_choice
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

def print_waiting
  arrow_prompt(messages('waiting'))
  sleep 2
  no_arrow_prompt(' ')
end

def print_choices(user_choice, computer_choice)
  arrow_prompt(messages('you_chose') + user_choice.to_s.capitalize)
  arrow_prompt(messages('computer_chose') + computer_choice.to_s.capitalize)
  no_arrow_prompt(' ')
end

def win?(first, second)
  (first == 'rock'     && second == 'scissors') ||
  (first == 'rock'     && second == 'lizard') ||
  (first == 'paper'    && second == 'rock') ||
  (first == 'paper'    && second == 'spock') ||
  (first == 'scissors' && second == 'paper') ||
  (first == 'scissors' && second == 'lizard') ||
  (first == 'lizard'   && second == 'paper') ||
  (first == 'lizard'   && second == 'spock') ||
  (first == 'spock'    && second == 'scissors') ||
  (first == 'spock'    && second == 'rock')
end

def display_results(player, computer)
  if win?(player, computer)
    arrow_prompt(messages('you_won'))
  elsif win?(computer, player)
    arrow_prompt(messages('computer_won'))
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

def display_score(player,
                  computer,
                  player_score,
                  computer_score)
  keep_score(player,
             computer,
             player_score,
             computer_score)
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

This game varies a bit from the traditional Rock, Paper Scissors...

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

MSG

play = nil

loop do #main loop
  arrow_prompt(info)
  play = play?
  break if play == 'no'

  print_start

  player_score = 0
  computer_score = 0
  current_round = 0

  loop do #score loop 
    current_round += 1

    print_round(current_round)
    print_score_tally(player_score, computer_score)

    user_choice = get_user_choice
    computer_choice = get_computer_choice
      
    print_waiting
    print_choices(user_choice, computer_choice)

    display_results(user_choice, computer_choice)

    player_score, computer_score = keep_score(user_choice,
                                              computer_choice,
                                              player_score,
                                              computer_score)

    print_score_tally(player_score, computer_score)

    break if player_score == 3 || computer_score == 3
  end

  break unless play_again? == 'yes'
end
which_exit_message?(play, name)

