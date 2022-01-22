=begin

Pseudo-code
-----------
Given a collection of integers.

Iterate through the collection one by one.
  - save the first value as the starting value.
  - for each iteration, compare the saved value with the current value.
  - if the saved value is greater, or it's the same
    - move to the next value in the collection
  - otherwise, if the current value is greater
    - reassign the saved value as the current value

After iterating through the collection, return the saved value.


Formal Pseudo-code
------------------
START

# Given a collection of integers called "numbers".

SET iterator = 1
SET saved_value = value of numbers collection at position 0

WHILE iterator <= length of numbers collection
  SET current_value = value of numbers collection at position iterator
  IF saved_value >= current_value
    proceed to next iteration
  ELSE
    saved_value = current_value
  
  iterator = iterator + 1

PRINT saved_value

END

=end

def find_max(numbers=[])
  return if numbers.nil?
  
  saved_value = numbers[0]
  
  numbers.each do |num|
    if !num.nil? && saved_value < num
      saved_value = num
    end
  end
  
  saved_value

end

p find_max([1, 7, 3, 99, 8, 3, 10])
p find_max([1, 7, 3, nil, 8, 3, 10])
p find_max([])
p find_max()


=begin

Pseudo-code
-----------

1. a method that returns the sum of two integers

Given two integers x and y,
Create result variable "sum" and assign it to the sum of x and y.
Display sum.

START
Given two integers x and y,
SET sum = x + y
PRINT sum
END

2. a method that takes an array of strings, and returns a string that is all 
   those strings concatenated together

Given an array of strings called "strings",
Create an empty string named "result".
Iterate over strings, concatenating each string to result.
Print result.

START
Given an array of strings called "strings",
SET result = ''
FOR EACH string in strings
  SET result = result + string
PRINT result
END

3. a method that takes an array of integers, and returns a new array with every 
   other element from the original array, starting with the first element.
   everyOther([1,4,7,2,5]) # => [1,7,5]

Given an array of integers called "numbers",
Create and empty array called "result".
Create a boolean called "toggle", initialized to true.
Iterate over numbers.
For each iteration, append the number to result if toggle = true.
Set toggle to its inverse.
Print result.

START
Given an array of integers called "numbers",
SET result = []
SET toggle = true
FOR EACH number in numbers
  Append number to result
  SET toggle = !toggle
PRINT RESULT
END

4. a method that determines the index of the 3rd occurrence of a given character
   in a string. For instance, if the given character is 'x' and the string is 
   'axbxcdxex', the method should return 6 (the index of the 3rd 'x'). If the 
   given character does not occur at least 3 times, return nil.

Given a character "search_char" and a string "str",
Split the string into an array of characters, and store in variable "chars".
Create a variable "count" and initialize it to 0.
Create a variable "index" and initialize it to 0.
Iterate through chars.
If the current char == search_char, increment count.
If count == 3, return index
Increment index.
Return nil.

START
Given a character "search_char" and a string "str",
SET chars = str.split
SET count = 0
FOR EACH char in chars
  IF char == search_char
    count += 1
    IF char == 3
      return index
  index += 1
RETURN nil
END

5. a method that takes two arrays of numbers and returns the result of merging 
   the arrays. The elements of the first array should become the elements at 
   the even indexes of the returned array, while the elements of the second 
   array should becoome the elements at the odd indexes. For instance:
   merge([1, 2, 3], [4, 5, 6]) # => [1, 4, 2, 5, 3, 6]

Given two arrays of numbers 'a' and 'b',
Create a result array named "result".
Create an index counter by initializing variable "index" to the length of 
array a, minus 1.
While index is less than the length of array a,
  Append the value at position "index" in array a, to result.
  Append the value at position "index" in array b, to result.
  Increment index
Print result.

START
Given two arrays of numbers 'a' and 'b',
SET result = []
SET index = a.length - 1
WHILE index < a.length
  result << a[index]
  index += 1
PRINT result

=end
