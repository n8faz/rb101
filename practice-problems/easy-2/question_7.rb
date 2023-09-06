# In the previous question we added Dino to our array
# We could have used either Array#concat or Array#push to add Dino to the family

# How can we add multiple items to our array? (Dino and Hoppy)

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.append("Dino", "Hoppy")

p flintstones

# push does same thing

# concat adds an array