=begin
PEDAC Lite

Palindrome Substrings

PROBLEM:

Given a string, write a method `palindrome_substrings` which returns all the 
substrings from a given string which are palindromes. Consider palindrome words 
case sensitive.

Test cases:
palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
palindrome_substrings("palindrome") == []
palindrome_substrings("") == []

P - [Understand the] Problem

Input: String

Output: Array of palindrome strings

Explicit Requirements
- Output strings must be palindromes.
- Palindrome words are case-sensitive.

Implicit Requirements
- If the input string is empty, return an empty array.
- A single character is not considered a palidrome.

Questions
- Will input always be strings?
- Will there be any spaces in the string?


E - Examples / Test cases


D - Data Structure

Output: An array


A - Algorithm

- Initialize a result variable to an empty array to store palindrome substrings.
- Use a 2-pointer approach to iterate through all substrings
  1. A Range from 0 to (string length - 1)
  2. A Range from the first Range to (string length - 1)
- Skip the substring if it is less than 2 characters.
- Check if each string is equal to its reverse. If so, push to the result array.
- Return the result array


C - Code

=end

def palindrome_substrings(str)
  return [] if str == ''
  result = []
  # length-1 and first+1 skip 1-character substrings.
  (0...str.length-1).each do |first|
    (first+1...str.length-1).each do |last|
      substring = str[first..last]
      # puts substring
      # next if substring.length < 2
      result << substring if (substring == substring.reverse)
    end
  end
  result
end

# puts palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# puts palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# puts palindrome_substrings("palindrome") == []
# puts palindrome_substrings("") == []


=begin
Approach 2

Algorithm
- Initialize a variable `result` to an empty array.
- Create an array `substrings_arr` containing substrings with length >= 2.
- Loop through substrings_arr.
  - Check if each substring is a palindrome. If so, add it to the result array.
- Return the result array

Example
string: 'halo'
ha
hal
halo
al
alo
lo

1st loop: From index 0 to (str.length - 2)
2nd loop: (1st loop index + 1) to (str.length - 1) or [x..] endless range

For each starting index from 0 to the next-to-last index position
  For each substring of length 2 to the largest possible starting from the index
    Extract the substring to the substring array
  end
end

Intermediate Pseudo-code
Given string `str`:
- Create empty array `result` to contain palindromic substrings.
- Create variable `starting_index` = 0 for starting index of substring.
- Start loop iterating over `starting_index` from 0 to (string.length - 2).
  - Create variable `num_chars` = 2 for the minimum substring length.
  - Start inner loop iterating over `num_chars` from 2 to (str.length - starting_index)
    - Extract substring of length `num_chars` from `str`, starting from `starting_index`.
    - Append extracted substring to `result`.
    - Increment `num_chars` by 1.
  - End inner loop.
  - Increment `starting_index` by 1.
- End outer loop.
- Return `result` array

Formal Pseudo-code
START

  SET result = []
  SET starting_index = 0

  WHILE starting_index <= string length - 2
    SET num_chars = 2
    WHILE num_chars <= string length - starting_index
      SET substring = num_chars characters starting from starting_index of str
      append substring to result array
      SET num_chars = num_chars + 1

    SET starting_index = starting_index + 1

  RETURN result

END

=end

def is_palindrome? (str)
  str == str.reverse
end

def find_substrings(str)
  result = []
  starting_index = 0
  
  while starting_index < (str.length - 2)
    num_chars = 2
    while num_chars <= (str.length - starting_index)
      substring = str[starting_index, num_chars]
      result << substring
      num_chars += 1
    end
    starting_index += 1
  end
  result
end

def pal_subs(str)
  result = []
  substrings_arr = find_substrings(str)
  substrings_arr.each do |substring|
    result << substring if is_palindrome?(substring)
  end
  result
end

puts pal_subs("supercalifragilisticexpialidocious") == ["ili"]
puts pal_subs("abcddcbA") == ["bcddcb", "cddc", "dd"]
puts pal_subs("palindrome") == []
puts pal_subs("") == []