# 11. Using select, reject, and other methods to return a new array identical
# in structure to the original, but containing only integers that are multiples 
# of 3.
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

p (arr.map do |sub_arr|
  sub_arr.reject do |n|
    (n % 3) != 0
  end
end)

p (arr.map do |sub_arr|
  sub_arr.select do |n|
    (n % 3) == 0
  end
end)