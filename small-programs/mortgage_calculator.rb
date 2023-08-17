def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i != 0 
end

prompt("Welcome to Mortgage Calculator. What is your name?")

name = nil 
loop do # name loop
  name = gets.chomp
  if name.empty?
    prompt("Make sure to use a valid name")
  else
    break
  end
end

prompt("Hello, #{name}!")

loop do # main loop

  loan_amount = nil
  loop do # loan amount loop
    prompt("Enter your loan amount:")
    loan_amount = gets.chomp
    if valid_number?(loan_amount)
      break
    else 
      prompt("That isn't a valid loan amount")
    end
  end 

  apr = nil
  loop do # APR loop
    prompt("Enter your APR (Annual Percentage Rate):")
    apr = gets.chomp
    if valid_number?(apr)
      break
    else 
      "That isn't a valid APR."
    end
  end

  loan_duration = nil
  loop do # loan duration loop
    prompt("Enter the duration of your loan in months:")
    loan_duration = gets.chomp
    if valid_number?(loan_duration)
      break
    else
      prompt("That isn't a valid loan duration.")
    end
  end

  loan_amount = loan_amount.to_i
  apr = apr.to_f 
  apr = apr * 0.01 
  monthly_interest = apr / 12 

  loan_duration = loan_duration.to_i 

  prompt("Calculating your monthly payment...")

  monthly_payment = loan_amount * (monthly_interest / (1 - (1 + monthly_interest)**(-loan_duration)))

  prompt("Your monthly payment is $#{monthly_payment}")

  prompt("Would you like to run that again? (Y to run again)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for using the mortgage calculator. See ya!")


