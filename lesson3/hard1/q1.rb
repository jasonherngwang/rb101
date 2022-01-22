# greeting gets initialized to `nil` even though `if` branch doesn't get
# executed.
if true
  if false
    greeting = "hello world"
  end
end

puts greeting
