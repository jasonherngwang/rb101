# 1. Turn this array into a hash where the names are the keys and the values are the positions in the array.
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# map with index
# p flintstones.map.with_index { |name, index| [name, index] } .to_h

# Method chaining each_with_index and with_object
p (flintstones.each_with_index.with_object({}) do |(name, index), hash|
  hash[name] = index
end)

# Only each_with_index
hash = {}
flintstones.each_with_index do |name, index|
  hash[name] = index
end
p hash

# 2. Add up all of the ages from the Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

p ages.values.inject(:+)

sum_ages = 0
ages.each { |name, age| sum_ages += age }
p sum_ages

# 3. Remove people with age 100 and greater.
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
p ages.reject! { |k, v| v >= 100}
p ages.keep_if { |k, v| v < 100}

# 4. Pick out the minimum age from our current Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
p ages.values.min

# 5. Find the index of the first name that starts with "Be"
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.index { |name| name[..1] == 'Be'}
p flintstones.bsearch_index { |name| name.start_with?('Be') }


# 6. Amend this array so that the names are all shortened to just the first three characters:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.map! { |name| name[0,3] }

# 7. Create a hash that expresses the frequency with which each letter occurs in this string:
statement = "The Flintstones Rock"
# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

hash = Hash.new(0)
statement.each_char { |char| hash[char] += 1 if char != ' ' }
# hash = hash.sort_by { |char, freq| freq }.reverse.to_h
p hash

p (statement.chars.each_with_object({}) do |char, hash|
  next if char == ' '
  if hash[char]
    hash[char] += 1
  else
    hash[char] = 1
  end
end)

result = {}
statement.chars.uniq.each do |char|
  result[char] = statement.count(char) if char != ' '
end
p result

# 8. What happens when we modify an array while we are iterating over it? What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
# Print numbers[0]: 1. After shift, numbers => [2,3,4]
# Print numbers[1]: 3. After shift, numbers => [3,4]
# Print numbers[2]: nil. After shift, numbers => [4]
# Print numbers[3]: nil. After shift, numbers => []

# What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
# Print numbers[0]: 1. After pop, numbers => [1,2,3]
# Print numbers[1]: 2. After pop, numbers => [1,2]
# Print numbers[2]: nil. After pop, numbers => [1]
# Print numbers[3]: nil. After pop, numbers => []


# 9. titleize
words = "the flintstones rock"

def titleize(words)
  words.split.map(&:capitalize).join(' ')
end

p titleize(words)# == "The Flintstones Rock"

# 10. Modify the hash such that each member of the Munster family has an 
# additional "age_group" key that has one of three values describing the age 
# group the family member is in (kid, adult, or senior). Your solution should 
# produce the hash below

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# { "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
#   "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
#   "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
#   "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
#   "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }

munsters.each do |name, data|
  age_group = case data['age']
              when 0...18  then 'kid'
              when 18...65 then 'adult'
              else              'senior'
              end
  
  # age_group = if data['age'] >= 65
  #               'senior'
  #             elsif data['age'] >= 18
  #               'adult'
  #             else
  #               'kid'
  #             end
  data['age_group'] = age_group
end

p munsters

munsters.transform_values! do |data|
  age_group = if data['age'] >= 65
                'senior'
              elsif data['age'] >= 18
                'adult'
              else
                'kid'
              end
  data.merge({"age_group" => age_group})
end

# p munsters

