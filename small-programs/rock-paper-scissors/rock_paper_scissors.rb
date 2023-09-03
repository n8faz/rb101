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

def prompt(message)
  puts "=> #{message}"
end

def abbreviation(user_choice)
  VALID_ABBREVIATIONS[user_choice] 
end

def play?
  answer = nil
  loop do
    prompt(messages('play?'))
    answer = gets.chomp
    if answer.downcase.start_with?('y')
      answer = 'yes'
      break
    elsif answer.downcase.start_with?('n')
      answer = 'no'
      break
    else
      prompt(messages('play_invalid'))
    end
  end
  answer
end

def which_exit_message?(play, name)
  if play == 'no'
    prompt(messages('didnt_play') + "#{name}.")
  else 
    prompt(messages('thanks') + "#{name}!")
  end
end

def get_name
  name = nil
  loop do
    name = gets.chomp
    if name.empty? || name.start_with?(' ')
      prompt(messages('invalid_name'))
    else
      break
    end
  end
  name
end

def get_user_choice
  choice = nil
    loop do
      prompt(messages('choose'))
      choice = gets.chomp.downcase
      if VALID_CHOICES.include?(choice)
        break
      elsif VALID_ABBREVIATIONS.include?(choice)
        choice = abbreviation(choice)
        break
      else
      prompt(messages('invalid_choice'))
      end
    end
  choice
end

def get_computer_choice
  VALID_CHOICES.sample
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
    prompt(messages('you_won'))
  elsif win?(computer, player)
    prompt(messages('computer_won'))
  else
    prompt(messages('tie'))
  end
end

def keep_score(player, computer, player_score, computer_score)
  if win?(player, computer)
    player_score += 1
  elsif win?(computer, player)
    computer_score += 1
  end
  [player_score, computer_score]
end

def display_score(player, computer, player_score, computer_score)
  keep_score(player, computer, player_score, computer_score)
end

# Program Start

clear_screen

prompt(messages('welcome'))

name = get_name

info = <<-MSG
Hi, #{name}!

This game varies a bit from the traditional Rock, Paper Scissors...

As I'm sure you are aware; Rock crushes Scissors, Scissors cuts Paper, and Paper covers Rock. In this game, you can also choose Lizard or Spock. Rock crushes Lizard, Lizard poisons Spock, Spock smashes Scissors, Scissors decapitates Lizard, Lizard eats Paper, Paper disproves Spock, and Spock vaporizes Rock.


MSG
play = nil
loop do
  prompt(info)
  play = play?
  break if play == 'no'

  loop do # main loop
    player_score = 0
    computer_score = 0

    loop do #score loop 
      user_choice = get_user_choice
      computer_choice = get_computer_choice

      prompt(messages('you_chose') + user_choice.to_s)
      prompt(messages('computer_chose') + computer_choice.to_s)

      display_results(user_choice, computer_choice)

      player_score, computer_score = keep_score(user_choice, computer_choice, player_score, computer_score)
      prompt(messages('score'))
      prompt(messages('your_score') + player_score.to_s)
      prompt(messages('computer_score') + computer_score.to_s)

      break if player_score == 3 || computer_score == 3
    end
    prompt(messages('again?'))
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
end
which_exit_message?(play, name)

