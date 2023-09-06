# Shorten the following sentence:

advice = "Few things in life are as important as house training your pet dinosaur."

# Review the String#slice! documentation, and use that method to make the return value "Few things in life are as important as ". But leave the advice variable as "house training your pet dinosaur."

# As a bonus, what happens if you use the string#slice method instead? 

# slice does not mutate so advice string remains unchanged

p advice.slice!("house training your pet dinosaur.")
p advice 