# 13. Return a new array containing the same sub-arrays as the original but 
# ordered logically by only taking into consideration the odd numbers they 
# contain.
arr = [[1, 6, 9], [1, 4, 9], [1, 6, 7], [1, 8, 3]]
# expected return value: [[1, 8, 3], [1, 6, 7], [1, 4, 9], [1, 6, 9]]

p (arr.sort_by do |sub_arr|
  sub_arr.select { |n| n.odd? }
end)