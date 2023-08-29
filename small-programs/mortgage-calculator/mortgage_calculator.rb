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

def positive_number?(num)
  num.to_i > 0
end

def valid_number?(num)
  number?(num) || positive_number?(num)
end

prompt(MESSAGES['welcome'])

name = nil
loop do # name loop
  name = gets.chomp
  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

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
  loan_amount = nil
  loop do # loan amount loop
    prompt(MESSAGES['loan_amount'])
    loan_amount = gets.chomp.gsub(',', '').gsub('$', '')
    if valid_number?(loan_amount)
      break  
    else 
      prompt(MESSAGES['invalid_amount'])
    end
  end

  apr = nil
  loop do # APR loop
    prompt(MESSAGES['apr'])
    apr = gets.chomp
    if valid_number?(apr)
      break
    else 
      prompt(MESSAGES['invalid_apr'])
    end
  end

  duration_in_months = nil
  loop do # loan duration loop
    prompt(MESSAGES['loan_duration'])
    loan_duration = gets.chomp
    if valid_number?(loan_duration)
      duration_in_months = loan_duration.to_f * MONTHS_IN_YEAR
      break
    else 
      prompt(MESSAGES['invalid_duration'])
    end
    duration_in_months
  end

  loan_amount = loan_amount.to_i
  apr = apr.to_f
  apr *= 0.01
  monthly_interest = apr / MONTHS_IN_YEAR

  prompt(MESSAGES['calculating'])

  monthly_payment = loan_amount *
                    (monthly_interest /
                    (1 - (1 + monthly_interest)**(-duration_in_months)))
  monthly_payment = monthly_payment.round(2)
  prompt(MESSAGES['monthly_payment'] + "$#{monthly_payment}")

  prompt(MESSAGES['again?'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
  system "clear"
end

prompt(MESSAGES['thanks'])