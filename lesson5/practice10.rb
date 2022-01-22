# 10. Without modifying the original array, use map to return a new array with 
# the same structure but with each integer incremented by 1.
arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]
p (arr.map do |hsh|
  (hsh.map do |k, v|
    [k, v + 1]
  end).to_h
end)
p arr