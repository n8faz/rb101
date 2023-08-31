require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

MONTHS_IN_YEAR = 12

def clear_screen
  system "clear"
end

def messages(message)
  MESSAGES[message]
end

def arrow_prompt(message)
  puts "=> #{message}"
end

def arrow_prompt_yaml(message)
  yaml_message = MESSAGES[message]
  puts "=> #{yaml_message}"
end

def no_arrow_prompt(message)
  puts message
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
  number?(num) && positive_number?(num)
end

def get_name
  name = nil
  loop do
    name = gets.chomp
    if name.empty? || name.start_with?(' ')
      arrow_prompt_yaml('valid_name')
    else
      break
    end
  end
  name
end

def get_loan_amount
  loan_amount = nil
  loop do
    arrow_prompt_yaml('loan_amount')
    loan_amount = gets.chomp.delete("$").delete(",")
    if valid_number?(loan_amount)
      break
    else
      arrow_prompt_yaml('invalid_amount')
    end
  end
  loan_amount.to_f
end

def get_apr
  apr = nil
  loop do
    arrow_prompt_yaml('apr')
    apr = gets.chomp.delete("%")
    if valid_number?(apr) || apr.to_i == 0
      break
    else
      arrow_prompt_yaml('invalid_apr')
    end
  end
  apr.to_f
end

def month_or_year?
  unit = nil
  loop do
    arrow_prompt_yaml('month_or_year?')
    unit = gets.chomp
    if unit.downcase.start_with?('y')
      unit = 'year'
      break
    elsif unit.downcase.start_with?('m')
      unit = 'month'
      break
    else
      arrow_prompt_yaml('invalid_month_or_year')
    end
  end
  unit
end

def get_loan_duration(unit)
  duration_in_months = nil
  loop do
    arrow_prompt_yaml('loan_duration')
    loan_duration = gets.chomp
    if valid_number?(loan_duration) && unit == 'year'
      duration_in_months = loan_duration.to_f * MONTHS_IN_YEAR
      break
    elsif valid_number?(loan_duration) && unit == 'month'
      duration_in_months = loan_duration.to_f
      break
    else
      arrow_prompt_yaml('invalid_duration')
    end
  end
  duration_in_months
end

def calculate_monthly_interest(apr)
  apr *= 0.01
  apr / MONTHS_IN_YEAR
end

def calculate_monthly_payment(loan_amount,
                              monthly_interest,
                              duration_in_months)
  if monthly_interest == 0
    monthly_payment = loan_amount / duration_in_months
  else
    monthly_payment = loan_amount *
                      (monthly_interest /
                      (1 - 
                      ((1 + monthly_interest)**(-duration_in_months))))
  end
  monthly_payment.round(2)
end

def calculate_interest_paid(loan_amount,
                            monthly_payment,
                            duration_in_months)
  total_interest = (monthly_payment * duration_in_months) - loan_amount
  total_interest.round(2)
end

def print_calculating
  arrow_prompt_yaml('calculating')
  sleep 2
  no_arrow_prompt(' ')
end

def print_monthly_interest(monthly_interest)
  arrow_prompt(messages('monthly_interest') + monthly_interest.round(4).to_s)
end

def print_duration_in_months(duration_in_months)
  arrow_prompt(messages('duration_in_months') +
              "#{duration_in_months.to_i} months")
end

def print_monthly_payment(monthly_payment)
  arrow_prompt(messages('monthly_payment') +
              "$#{format('%.2f', monthly_payment)}")
end

def print_interest_paid(monthly_interest, total_interest)
  if monthly_interest == 0
    arrow_prompt(messages('congrats'))
  else
    arrow_prompt(messages('total_interest_paid') +
                "$#{format('%.2f', total_interest)}")
  end
end

def print_calculations(monthly_interest,
                       duration_in_months,
                       monthly_payment,
                       total_interest)
  print_monthly_interest(monthly_interest)
  print_duration_in_months(duration_in_months)
  print_monthly_payment(monthly_payment)
  print_interest_paid(monthly_interest, total_interest)
  no_arrow_prompt(' ')
end

def run_again?
  arrow_prompt_yaml('again?')
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

# Program start

clear_screen

arrow_prompt_yaml('welcome')

name = get_name

info = <<-MSG
Hello, #{name}!

This Mortgage Calculator will calculate the following:
1) Monthly Interest Rate
2) Loan Duration in Months
3) Monthly Payment
4) Total Interest Paid

You will need to provide:
1) The Loan Amount
2) The Annual Percentage Rate (APR)
3) The Loan Duration

MSG

loop do # main loop
  arrow_prompt(info)

  loan_amount = get_loan_amount
  apr = get_apr
  duration_unit = month_or_year?
  duration_in_months = get_loan_duration(duration_unit)
  monthly_interest = calculate_monthly_interest(apr)
  monthly_payment = calculate_monthly_payment(loan_amount,
                                              monthly_interest,
                                              duration_in_months)
  total_interest = calculate_interest_paid(loan_amount,
                                           monthly_payment,
                                           duration_in_months)

  print_calculating
  print_calculations(monthly_interest,
                     duration_in_months,
                     monthly_payment,
                     total_interest)

  break unless run_again?

  clear_screen
end

arrow_prompt(messages('thanks') + "#{name}!")
