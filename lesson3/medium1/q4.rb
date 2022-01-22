# Rolling buffer
# When full, new elements overwrite old elements.

# << vs +
# << will modify the array in-place and not consume additional memory.
# + will reassign to a new object every time, consuming memory.

# << will modify the original array.
# + will modify the local array. The original array must be reassigned to 
# the return value of the method for changes to take effect.


def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end


buffer = [1, 2, 3]
max_buffer_size = 3
new_element = 4
p rolling_buffer1(buffer, max_buffer_size, new_element)


input_array = [1, 2, 3]
max_buffer_size = 3
new_element = 4
p rolling_buffer2(input_array, max_buffer_size, new_element)