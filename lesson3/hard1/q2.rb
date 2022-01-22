greetings = { a: 'hi' }
# informal_greeting points to the object containing 'hi'
informal_greeting = greetings[:a]
# Destructive method invocation affects greetings.
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings
# { a: 'hi there' }

# Shallow copy
greetings = { a: 'hi' }
informal_greeting = greetings[:a].dup
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings          #  => {:a=>'hi'}

greetings = { a: 'hi' }
informal_greeting = greetings[:a].clone
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings          #  => {:a=>'hi'}