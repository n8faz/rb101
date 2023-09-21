# Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator. A user passes in two numbers, and the calculator will keep computing the sequence until some limit is reached. 

# Ben coded up this implementation but complained that as soon as he ran it, he got an error. Something about the limit variable. What's wrong with the code?

limit = 15

def fib(first_num, second_num)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"

# The variable limit is not defined inside the method nor is the local variable outside the method passed into it. If Ben doesn't want to pass the limit variable into the method as an argument he needs to make limit a constant variable that can be accessed anywhere throughout the program. He should probably just pass it into the method as an argument so the user can decide the limit themselves. 