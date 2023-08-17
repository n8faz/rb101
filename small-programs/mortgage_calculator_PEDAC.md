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
        
