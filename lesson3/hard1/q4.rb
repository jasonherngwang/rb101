# Requirements
# IP address has exactly 4 components.

def is_an_ip_number?(num)
  (0..255).include? num.to_i
end

# def dot_separated_ip_address?(input_string)
#   dot_separated_words = input_string.split(".")
#   while dot_separated_words.size > 0 do
#     word = dot_separated_words.pop
#     break unless is_an_ip_number?(word)
#   end
#   return true
# end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")

  if dot_separated_words.size == 4
    dot_separated_words.all? { |num| is_an_ip_number? num }
  else
    puts 'Does not have 4 components.'
    false
  end
end

puts dot_separated_ip_address?('192.169.1.0')
puts dot_separated_ip_address?('192.169.1.x')
puts dot_separated_ip_address?('1.0')
puts dot_separated_ip_address?('')