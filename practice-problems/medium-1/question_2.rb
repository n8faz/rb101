# The result of the following statement will be an error:

# puts "the value of 40 + 2 is " + (40 + 2)

# Why is this and what are two possible ways to fix this?

# String concatenation with a string and integer. Integer needs to be a string for string concatenation to work. Can either make the integer into a string with #.to_s or switch to string interpolation

# Integer to string

puts "the value of 40 + 2 is " + (40 + 2).to_s

# String interpolation

puts "the value of 40 + 2 is #{(40 + 2)}"