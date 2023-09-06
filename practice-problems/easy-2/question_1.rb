# See if "Spot" is present in this hash of people and their age 

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.key?("Spot")

p ages.include?("Spot")

p ages.key("Spot") # returns nil if not present

p ages.member?("Spot")