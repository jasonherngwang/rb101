# In this hash of people and their age,

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# see if "Spot" is present.

puts ages.key? 'Spot'

# Bonus: What are two other hash methods that would work just as well for this solution?
puts ages.include? 'Spot'
puts ages.member? 'Spot'