# The Ruby Array class has several methods for removing items from the array. Two of htem have very similar names. Let's see how they differ:

numbers = [1, 2, 3, 4, 5]

#What do the following method calls do (assume we reset numbers to original array between method calls)?

numbers.delete_at(1) # this will delete value in array at the index "1", so 2

numbers.delete(1) # this will delete the value 1 in the array