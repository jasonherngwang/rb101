# 5. Find total age of the males.
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Iterate over all members. Can also use each_value.
total_age = 0
munsters.each do |_, details|
  if details['gender'] == 'male'
    total_age += details['age']
  end
end
p total_age

# Extract ages then sum
p (munsters.map do |name, details|
  details['gender'] == 'male' ? details['age'] : 0
end).sum