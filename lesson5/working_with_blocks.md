# Exercise 3
```ruby
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end

# => 1
# => 3
# => [1, 3]
```

## Step-by-step Breakdown
| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| --- | --- | --- | --- | --- | --- |
| 1 |  method call (`map`) | outer array | none | new array `[1, 3]` | no |
| 1-4 | block execution | each sub-array | none | Integer at index 0 of sub-array | yes, by `map` for transformation |
| 2 | method call `first` | each sub-array | none | elem at index 0 of sub-array | yes, by `puts` |
| 3 | method call `puts` | Integer at index 0 of sub-array | prints a string representation of an Integer | `nil` | no |
| 4 | method call `first` | each sub-array | none | elem at index 0 of sub-array | yes, used to determine return value of block |

# Exercise 4
```ruby
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end

# => 18
# => 7
# => 12
# => [[18, 7], [3, 12]]
```

## Step-by-step Breakdown
`each` ignores the return value of each block, so the return values of block executions in lines 1-7 and 2-6 are not used.

| Line | Action | Object | Side Effect | Return Value | Return Value Used? |
| --- | --- | --- | --- | --- | --- |
| 1 | Variable assignment to `my_arr` | `[[18, 7], [3, 12]]` | `my_arr` references a new object | `[[18, 7], [3, 12]]` | No |
| 1 | method call `each` | `[[18, 7], [3, 12]]` | None | Calling object `[[18, 7], [3, 12]]` | Yes, assigned to `my_arr` |
| 1-7 | block execution (1st level) | Each sub-array | None | The original sub-array | No |
| 2 | method call `each` | Sub-array `arr` | None | Calling object (sub-array) | Yes, used to determine the return value of the block (1st level) |
| 2-6 | block execution (2nd level) | Integer element of sub-array `arr` during the iteration | None | `nil` | No |
| 3 | Comparison `>` | Integer element of sub-array `arr` during the iteration | None | `true` or `false` | Yes, to determine whether to enter this branch of the `if` statement |
| 3-5 | `if` conditional statement/expression | Result of expression `num > 5` | None | `nil` | Yes, used to determine return value of inner block |
| 4 | method call `puts` | Integer element of sub-array `arr` during the iteration | Prints the string representation of `num` | `nil` | Yes, used to determine the return value of the `if` statement if that branch is executed. |

# Exercise 5
```ruby
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end

# => [[2, 4], [6, 8]]
```
2-level `map`

`map` will return a new transformed array, so the return values matter.

Method `map` is invoked on multi-dimentional array `[[1, 2], [3, 4]]`.

Outer level `map` has one parameter `arr` which is a sub-array of the original array, during each iteration.

Inner level `map` is invoked on the sub-array. It has one parameter `num` which is an Integer object of the sub-array, during each iteration.

Inside the block of the inner level `map`, the expression `num * 2` evaluates to an integer. This is the return value of the block.

Inner level `map` return the sub-array with its Integer elements doubled. This is the return value of the block of the outer level `map`.

Outer level `map` returns a new array `[[2, 4], [6, 8]]`.

