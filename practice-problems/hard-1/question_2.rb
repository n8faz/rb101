# What is the result of the last line in the code below?

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

# { a: 'hi there' }

# informal_greeting is a reference to the original object, which is then being mutated, affecting the value in key a in greetings.