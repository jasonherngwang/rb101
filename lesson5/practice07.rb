# 7. What will `a` and `b` be?
a = 2
b = [5, 8]
# Nest 1 reference to a number, 1 reference to an array
arr = [a, b]      # => [2, [5, 8]]

# Element update on the first element of arr.
# Cannot change immutable number 2, so `a` remains 2.
arr[0] += 2       # arr == [4, [5, 8]]

# arr[1][0] references first element of array object. Both arr and b reference it.
# Element update on the first element. Affects both arr and b.
arr[1][0] -= a    # arr == [4, [3, 8]], b == [3, 8]

p a
p b
# a == 2
# b == [3, 8]