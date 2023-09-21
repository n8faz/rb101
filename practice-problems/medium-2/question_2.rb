# Let's take a look at another example with a small difference in the code from Question 1

a = 42
b = 42
c = a

puts a.object_id # Object id for A
puts b.object_id # Same object id as A
puts c.object_id # Same object id as A

# Integers are immutable, value cannot be changed, so a b and c each reference the same integer object.