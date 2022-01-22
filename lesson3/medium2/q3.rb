def tricky_method(a_string_param, an_array_param)
  # New local variables initialized
  a_string_param += "rutabaga"  # Reassignment, non-mutating
  an_array_param << "rutabaga"  # Mutating method; affects original argument var
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"  # => pumpkins
puts "My array looks like this now: #{my_array}"    # => ['pumpkins', 'rutabaga']