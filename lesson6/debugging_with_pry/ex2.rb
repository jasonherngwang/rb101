require 'pry'

puts 'Pick option 1 or 2:'

user_input = gets.chomp.to_i
# binding.pry
if user_input == 1
  puts 'You picked option 1.'
elsif user_input == 2
  puts 'You picked option 2.'
else
  puts 'Invalid input.'
end
