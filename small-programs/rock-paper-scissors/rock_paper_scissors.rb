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

def prompt(message)
  puts "=> #{message}"
end

def abbreviation(user_choice)
  VALID_ABBREVIATIONS[user_choice] 
end

def get_user_choice
  choice = nil
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = gets.chomp
      if VALID_CHOICES.include?(choice)
        break
      elsif VALID_ABBREVIATIONS.include?(choice)
        choice = abbreviation(choice)
        break
      else
      prompt("That's not a valid choice.")
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
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie")
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


loop do # main loop
  player_score = 0
  computer_score = 0
  
  loop do #score loop 
    user_choice = get_user_choice
    computer_choice = get_computer_choice

    prompt("You chose: #{user_choice}; Computer chose: #{computer_choice}")

    display_results(user_choice, computer_choice)

    player_score, computer_score = keep_score(user_choice, computer_choice, player_score, computer_score)
    prompt("The score is: You: #{player_score} Computer: #{computer_score}")

    break if player_score == 3 || computer_score == 3
  end
  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
