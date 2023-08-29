MONTHS_IN_YEAR = 12

def prompt(message)
  puts "=> #{message}"
end

def float?(num)
  num.to_f.to_s == num
end

def integer?(num)
  num.to_i.to_s == num 
end

def number?(num)
  integer?(num) || float?(num)
end

def positive_number?(num)
  num.to_i > 0
end

def valid_number?(num)
  number?(num) || positive_number?(num)
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

welcome = <<-MSG
This tool will calculate the following:
1) Monthly Interest Rate
2) Loan Duration in Months
3) Monthly Payment

You will need to provide:
1) The Loan Amount
2) The Annual Percentage Rate (APR)
3) The Loan Duration

MSG

prompt("Hello, #{name}!")
prompt(welcome)

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
      prompt("That isn't a valid APR.")
    end
  end

  duration_in_months = nil
  loop do # loan duration loop
    prompt("Enter the duration of your loan:")
    loan_duration = gets.chomp
    if valid_number?(loan_duration)
      duration_in_months = loan_duration.to_f * MONTHS_IN_YEAR
      break
    else 
      prompt("That isn't a valid loan duration.")
    end
    duration_in_months
  end

  loan_amount = loan_amount.to_i
  apr = apr.to_f
  apr *= 0.01
  monthly_interest = apr / MONTHS_IN_YEAR

  #loan_duration = loan_duration.to_i

  prompt("Calculating your monthly payment...")

  monthly_payment = loan_amount *
                    (monthly_interest /
                    (1 - (1 + monthly_interest)**(-duration_in_months)))
  monthly_payment = monthly_payment.round(2)
  prompt("Your monthly payment is $#{monthly_payment}")

  prompt("Would you like to run that again? (Y to run again)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
  system "clear"
end

prompt("Thank you for using the mortgage calculator. See ya!")