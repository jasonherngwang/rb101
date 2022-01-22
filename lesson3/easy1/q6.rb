# Starting with the string:
famous_words = "seven years ago..."
# show two different ways to put the expected "Four score and " in front of it.

puts 'Four score and ' + famous_words
puts 'Four score and ' << famous_words
puts 'Four score and '.concat famous_words
puts ['Four score and ', famous_words].join

