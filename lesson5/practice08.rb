# 8. Using each, output all vowels.
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |_, value|
  value.each do |word|
    word.chars.each do |char|
      puts char if 'aeiou'.include? char
    end
  end
end