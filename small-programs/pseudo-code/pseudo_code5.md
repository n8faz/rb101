# a method that takes two arrays of numbers and returns the result of merging the arrays. The elements of the first array should become the elements at the even indexes of the returned array, while the elements of the second array should become the elements at the odd indexes # 

Casual 
 Given two arrays of numbers
 Create an empty array 'merged_array'
 Set variable index1 to 0 and index2 to 0 
 While index1 is less than the length of first array 
  Add the number located at index1 of first array to 'merged_array'
  Add 1 to index1
 While index2 is less than the length of the second array
  Add the number located at index2 from second array to 'merged_array'
  Add 1 to index2
 Return 'merged_array'

Formal
  START

  Given two arrays of numbers (array1, array2)

  SET merged_array = []
  SET index1 = 0
  SET index2 = 0

  WHILE index1 < length of array1
    merged_array += array1[index1]
    index1 += 1
  WHILE index2 < length of array2
    merged_array += array2[index2]
    index2 += 1
  
  PRINT merged_array

  END 
  
  