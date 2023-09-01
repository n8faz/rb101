# Describe the difference between ! and ? in Ruby and explain what would happen in the following scenarios #

! can mean a few things in ruby. It can represent "not" or denote that a method mutates its caller this is called a "bang" suffix.
? is a part of a ternary operator which takes 3 operands and is a short and concise conditional if/else statement

1. what is != and where should you use it?
    != represents "not equal to" and should be used in a conditional
2. put ! before something, like !user_name
    represents "not" so if it was put before true it would equal false.
    In this case, it would mean "not" user_name
3. put ! after something, like words.uniq!
    Typically means that a method would mutate the caller, but not always the case
    In this case it would mutate words into removing all duplicate values 
4. put ? before something
    If what is before the ? is a condition then it will act as an if/else statement
5. put ? after something
    Will represent a condition for a ternary operator
6. put !! before something, like !!user_name
    known as a "double bang". It will turn object to boolean equivalent