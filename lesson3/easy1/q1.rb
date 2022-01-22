numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers
=begin
Expect 
1
2
2
3
since uniq is not destructive and does not mutate numbers in-place.
=end