# Shorten the following sentence:

advice = "Few things in life are as important as house training your pet dinosaur."
# Review the String#slice! documentation, and use that method to make the 
# return value "Few things in life are as important as ". But leave the advice 
# variable as "house training your pet dinosaur.".

# p advice.slice!(0..38)
# p advice.slice("Few things in life are as important as ")
# p advice.slice!("Few things in life are as important as ")
p advice.slice!(0, advice.index('house'))

p advice

# As a bonus, what happens if you use the String#slice method instead?
# String does not get mutated.