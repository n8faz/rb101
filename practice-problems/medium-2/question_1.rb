# Every object in Ruby has acces to a method called object_id, which returns a numerical value that uniquely identifies the object. This method can be used to determine whether two variables are pointing to the same object.

# Take a look at the following code and predict the output:

a = "forty two"
b = "forty two"
c = a

puts a.object_id # object id for A
puts b.object_id  # different object id for B
puts c.object_id  # same object id as A
