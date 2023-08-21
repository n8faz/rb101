# Build a calculator program that does the following:
# asks for two numbers
# asks for the type of operation to perform: add, subtract, multiply or divide
# display the result
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def print_prompt(message)
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

print_prompt(messages('welcome'))
name = nil
loop do
  name = gets.chomp

  if name.empty?
    print_prompt(messages('valid_name'))
  else
    break
  end
end

print_prompt(messages('hi') + "#{name}!")

loop do # main loop
  number1 = nil
  loop do
    print_prompt(messages('first_number?'))
    number1 = gets.chomp

    if number?(number1)
      break
    else
      print_prompt(messages('invalid_number'))
    end
  end

  number2 = nil
  loop do
    print_prompt(messages('second_number?'))
    number2 = gets.chomp

    if number?(number2)
      break
    else
      print_prompt(messages('invalid_number'))
    end
  end

  operator_prompt = <<-MSG
  What operation would you like to perform?
  1) Add
  2) Subtract
  3) Multiply
  4) Divide
  MSG

  print_prompt(operator_prompt)

  operator = nil
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      print_prompt(messages('must_choose'))
    end
  end

  print_prompt("#{operation_to_message(operator)} " + messages('calculating'))

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
  print_prompt(messages('result') + " #{result}")

  print_prompt(messages('again?'))
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

print_prompt(messages('thanks'))
