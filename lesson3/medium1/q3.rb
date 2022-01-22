# Alan wrote the following method, which was intended to show all of the 
# factors of the input number:

def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end

def factors_new(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

# Fail if input is 0 or neg number.

# Divide by 0 error
# factors(0)
p factors_new(0)

# Infinite loop
# factors(-1)
p factors_new(-1)

p factors_new(10)

# Bonus 1
# number % divisor == 0 checks that the quotient is an integer, and that 
# there is no remainder.

# Bonus 2
# begin/end returns nil, so factors must be the last line in the method if we
# want to return its value.