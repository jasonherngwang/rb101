# 16. Write a method that returns one UUID when called with no parameters.
def generate_hex(num_chars = 1)
  hex = ''
  num_chars.times do
    hex << [*'0'..'9',*'a'..'f'].sample
  end
  hex
end

def generate_uuid
  sections = [8, 4, 4, 4, 12]
  sections.map { |n| generate_hex(n) }
    .join('-')
end

p generate_uuid