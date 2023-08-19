# PEDAC for Mortgage Calculator Assignment #

Build a mortgage calculator

Three pieces of information received:
  Loan amount
  Annual Percentage Rate (APR)
  Loan duration

From information received, calculate: 
  Monthly interest rate
  Loan duration in months
  Monthly payment 

Formula: 
  m = p * (j / (1 - (1 + j)**(-n)))
    m = monthly payment
    p = loan amount 
    j = monthly interest rate
    n = loan duration in months

Problem: Mortage calculator
          Input: Strings received from user to be converted to integers/floats
          Output: Calculations of monthly interest rate, loan duration, and monthly payment
          Rules:  Calculations must be correct
                  Dont use single letter variables

Examples: m = p * (j / (1 - (1 + j)**(-n)))

Data Structure: Strings converted to integers/floats
                
Algorithm: 
          Welcome user to mortage calculator by asking for name
          Ask user to provide loan amount
          Store loan amount into a variable converted to integer
          Ask user to provide APR
          Store APR into a variable converted to float
          Ask user to provide duration of loan (in months)
          Store duration of loan into a variable converted to integer
          Convert APR to monthly interest rate
            Take APR and divide by 12
          Calculate monthly payment using formula 

Code: Pseudo-code
      START
      PRINT "Welcome to Mortgage Calculator. What is your name?"
      SET name = nil
      LOOP name loop
        GET name = gets.chomp
        IF name.empty?
          PRINT "Make sure to use a valid name"
        ELSE 
          break
      END name loop 
      PRINT "Hello, #{name}!"
      LOOP main loop
        SET loan_amount = nil
        LOOP loan amount loop
          PRINT "Enter your loan amount" 
          GET loan_amount = gets.chomp
          IF loan_amount.to_i != 0
            break
          ELSE 
            "That isn't a valid loan amount." 
        END loan amount loop
        SET apr = nil
        LOOP APR loop
          PRINT "Enter your APR (Annual Percentage Rate)"
          GET apr = gets.chomp
          IF apr.to_i != 0
            break
          ELSE 
            "That isn't a valid APR."
        END APR loop
        SET loan_duration = nil
        LOOP loan duration loop
          PRINT "Enter the duration of your loan in months" 
          GET loan_duration = gets.chomp
          IF loan_duration.to_i != 0 
            break
          ELSE
            "That isn't a valid loan duration."
        END loan duration loop
        SET monthly_interest = apr / 12
        PRINT "Calculating your monthly payment..."
        SET monthly_payment = loan_amount * (monthly_interest / (1 - (1 + monthly_interest)**(-n)))
        PRINT "Your monthly payment is $#{monthly_payment}"
        PRINT "Would you like to run that again? (Y to run again)"
        GET answer = gets.chomp
        BREAK unless answer.downcase.start_with?('y')
      END main loop
      PRINT "Thank you for using the mortgage calculator. See ya!"
      END 