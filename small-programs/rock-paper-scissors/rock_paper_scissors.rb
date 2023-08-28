VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
VALID_ABBREVIATIONS = {'r' => 'rock',
                       'p' => 'paper', 
                       'sc' => 'scissors', 
                       'l' => 'lizard', 
                       'sp' => 'spock'
                      }

def prompt(message)
  puts "=> #{message}"
end

def abbreviation(user_choice)
  VALID_ABBREVIATIONS[user_choice] 
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

loop do # main loop
  choice = nil
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp
    choice = abbreviation(choice)
    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
