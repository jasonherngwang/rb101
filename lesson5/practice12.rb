# 12. Without using Array#to_h, return a hash where the key is the first item 
# in each sub array, and the value is the second item.
arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

p (arr.map.with_object({}) do |elem, hsh| 
  hsh[elem[0]] = elem[1]
end)