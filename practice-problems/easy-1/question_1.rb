# What would you expect the code to print out?

numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers 

=begin I expect the code to print out: 
1
2 
2
3
While #uniq method removes duplicate values it is not mutating so the numbers array remains unchanged 
=end 