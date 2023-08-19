# Build a calculator program that does the following:
# asks for two numbers
# asks for the type of operation to perform: add, subtract, multiply or divide
# display the result
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

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

def operation_to_message(op)
  operation = case op
                when '1'
                  'Adding'
                when '2'
                  'Subtracting'
                when '3'
                  'Mulitplying'
                when '4'
                  'Dividing'
              end
              
  operation
end

prompt(MESSAGES['welcome'])
name = nil
loop do
  name = gets.chomp

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt(MESSAGES['hi'] + "#{name}!")

loop do # main loop
  number1 = nil
  loop do
    prompt(MESSAGES['first_number?'])
    number1 = gets.chomp

    if number?(number1)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  number2 = nil
  loop do
    prompt(MESSAGES['second_number?'])
    number2 = gets.chomp

    if number?(number2)
      break
    else
      prompt(MESSAGES['invalid_number'])
    end
  end

  operator_prompt = <<-MSG
  What operation would you like to perform?
  1) Add
  2) Subtract
  3) Multiply
  4) Divide
  MSG

  prompt(operator_prompt)

  operator = nil
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['must_choose'])
    end
  end

  prompt("#{operation_to_message(operator)} " + MESSAGES['calculating'])

  result =  case operator
            when '1'
              number1.to_i + number2.to_i
            when '2'
              number1.to_i - number2.to_i
            when '3'
              number1.to_i * number2.to_i
            when '4'
              number1.to_f / number2.to_f
            end
  prompt(MESSAGES['result'] + " #{result}")

  prompt(MESSAGES['again?'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['thanks'])
