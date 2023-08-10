# a method that takes an array of integers, and returns a new array with every other element from the original array, starting with the first element #

Casual 
  Given an array of integers
  Create a new array
  Create a variable index and set to 0
  Iterate through array returning every other element, starting with the first element
    Return the element at index 'index' from the array
    Add that element to the new array
    Increment index by 2
  Return the new array 

Formal
  START
    Given an array of integers
  
  SET new_array = []
  SET index = 0 

  WHILE index < length of array
    READ array[index]
    new_array += array[index]
    index += 2 
  
  PRINT new_array

  END
  