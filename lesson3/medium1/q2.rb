# Fix the error:
# puts "the value of 40 + 2 is " + (40 + 2)

# Cannot coerce integer to string

puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{(40 + 2)}"
