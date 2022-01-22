def sum_even_num_row(row_num)
  rows = []
  start_int = 2
  
  (1..row_num).each do |current_row_num|
    row = create_row(start_int, current_row_num)
    rows << row
    start_int = row.last + 2
  end
  
  rows.last.sum
end

def create_row(start_int, row_length)
  row = []
  current_int = start_int
  while row.length < row_length
    row << current_int
    current_int += 2
  end
  row
end


# Examples
# row_num: 1 --> sum: 2
# row_num: 2 --> sum: 10
# row_num: 3 --> sum: 68

p sum_even_num_row(1)# == 2
p sum_even_num_row(2)# == 10
p sum_even_num_row(4)# == 68

# start_int: 2, length: 1 --> [2]
# start_int: 4, length: 2 --> [4, 6]
# start_int: 8, length: 3 --> [8, 10, 12]

# p create_row(2, 1) == [2]
# p create_row(4, 2) == [4, 6]
# p create_row(8, 3) == [8, 10, 12]