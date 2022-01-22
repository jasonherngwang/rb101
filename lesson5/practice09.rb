# 9. Return a new array of the same structure, with sub-arrays ordered in descending order.
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

p (arr.map do |subarray|
  subarray.sort do |a, b|
    b <=> a
  end
end)