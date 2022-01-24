require 'pry'

def my_method(num)
  a = 1
  binding.pry # Variable c will be undefined because it is not within scope.
  b = 2
end

c = 3

my_method(c)