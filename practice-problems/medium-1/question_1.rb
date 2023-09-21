# Write a one line program that outputs "The FLintstones Rock!" Ten times, with the subsequent line indented 1 space to the right

string = "The Flintstones Rock!"
space = ""
10.times do 
  puts space + string
  space << " "
end 

# One line solution

10.times { |num| puts (" " * num) + "The Flintstones Rock!" }
