# a method that determines the index of the 3rd occurrence of a given character in a string. For instance, if the given character is 'x' and the string is 'axbxcdxex', the method should return 6 (the index of the 3rd 'x' ). If the given character does not occur at least 3 times, return nil #

Casual
  Given a string 
  Given a character
  Set a variable occur_count to 0 
  If given character occurs in the string at least 3 times then return the index of that third occurrence 
    For each character in string 
      If the character matches the given character add 1 to occur_count
      If occur_count = 3
        return the index
      I occur_count is less than 3
        return nil
    
Formal
  START

  Given a string and a specific character
  
  SET target = given character
  SET occur_count = 0
  FOR each character in string and corresponding index
    IF character = target
      occur_count += 1 
    IF occur_count = 3
      PRINT corresponding index
    ELSE 
      PRINT nil 
  
  END
