# How could the following method be simplified without changing its return value?

def color_valid(color)
  (color == "blue" || color == "green")
end

p color_valid("blue")
p color_valid("red")

