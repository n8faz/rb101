require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

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

def positive_or_zero?(num)
  num.to_i >= 0
end

def valid_number?(num)
  number?(num) && positive_or_zero?(num)
end

def name_loop(name)
  name = nil
  loop do
    name = gets.chomp
    if name.empty?
      prompt(MESSAGES['valid_name'])
    else
      break
    end
  end
  name
end

def loan_amount_loop(loan_amount)
  loan_amount = nil
  loop do
    prompt(MESSAGES['loan_amount'])
    loan_amount = gets.chomp.gsub(',', '').gsub('$', '')
    if valid_number?(loan_amount)
      break  
    else 
      prompt(MESSAGES['invalid_amount'])
    end
  end
  loan_amount.to_i
end

def apr_loop(apr)
  apr = nil
  loop do
    prompt(MESSAGES['apr'])
    apr = gets.chomp
    if valid_number?(apr)
      break
    else 
      prompt(MESSAGES['invalid_apr'])
    end
  end
  apr.to_f
end

def loan_duration_loop(loan_duration)
  duration_in_months = nil
  loop do
    prompt(MESSAGES['loan_duration'])
    loan_duration = gets.chomp
    if valid_number?(loan_duration)
      duration_in_months = loan_duration.to_f * MONTHS_IN_YEAR
      break
    else 
      prompt(MESSAGES['invalid_duration'])
    end
  end
  duration_in_months
end

def monthly_interest(apr)
  apr *= 0.01
  monthly_interest = apr / MONTHS_IN_YEAR
  monthly_interest
end

def monthly_payment(loan_amount, monthly_interest, duration_in_months)
  monthly_payment = loan_amount *
                    (monthly_interest /
                    (1 - (1 + monthly_interest)**(-duration_in_months)))          
  monthly_payment = monthly_payment.round(2)
  monthly_payment
end

prompt(MESSAGES['welcome'])

name = name_loop(name)

info = <<-MSG
Hello, #{name}!

This tool will calculate the following:
1) Monthly Interest Rate
2) Loan Duration in Months
3) Monthly Payment

You will need to provide:
1) The Loan Amount
2) The Annual Percentage Rate (APR)
3) The Loan Duration

MSG

loop do # main loop
  prompt(info)
  loan_amount = loan_amount_loop(loan_amount)
  apr = apr_loop(apr)
  duration_in_months = loan_duration_loop(duration_in_months)
  monthly_interest = monthly_interest(apr)
  
  prompt(MESSAGES['calculating'])

  monthly_payment = monthly_payment(loan_amount, monthly_interest, duration_in_months)

  prompt(MESSAGES['monthly_payment'] + "$#{monthly_payment}")

  prompt(MESSAGES['again?'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
  system "clear"
end

prompt(MESSAGES['thanks'])