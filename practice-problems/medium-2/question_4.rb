# To drive that last one home...let's turn the tables and have the string show a modified output, while the array thwarts the method's efforts to modify the user's version of it.

def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  an_array_param = ['pumpkins', 'rutabaga']
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# my_string is now "pumpkinsrutabaga" as the method is mutating the called string. 

# my_array is still just ["pumpkins"]. an_array_param is being reassigned inside the method and has no effect on the object passed to it.