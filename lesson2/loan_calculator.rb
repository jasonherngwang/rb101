=begin
Problem
-------
Ask user for 3 inputs:
1. Loan amount in dollars and cents - Float loan_amount (e.g. 1,000,000.00)
2. Annual Percentage Rate (APR) - Float rate_annual (e.g. 3.25)
   This is entered as a % value, not a decimal.
3. Loan duration in years - Float duration_years (e.g. 30)

Calculate:
1. Monthly interest rate - Float rate_monthly
   This is converted from the % apr to a decimal value.
2. Loan duration in months - Float duration_months (e.g. 360)
3. Monthly payment in dollars and cents - Float payment_monthly

Equations:
rate_monthly = (rate_annual + 1)**(1/12)-1

duration_months = duration_years * 12

payment_monthly = loan_amount *
(rate_monthly / (1 - (1 + rate_monthly)**(-duration_months) ) )

Implicit Requirements:
- Need to perform validation on all numbers. Do not allow user input to proceed
  until valid inputs are provided.
- Avoid integer division.
- Format dollar values to two decimal places; round up.

Examples
--------
Example 1: House in California
Inputs: $1,000,000 loan, 3.0% APR, 30 years
Output: 4,194.24 monthly payment

Example 2: House in Ohio
Inputs: $300,000 loan, 2.75% APR, 30 years
Output: $1,219.32 monthly payment

Edge Cases
----------
Case 1: Negative Value Inputs
Inputs: -$1 loan, -1% APR, -1 year loan duration
Output: Display error message and ask for valid positive input.

Case 2: Zero-value Inputs
Inputs: $0 loan, 0% APR, 0 year loan duration
Output: These are valid inputs but require special calculations to avoid
        exceptions in the calculation formulas.
        1. If loan is $0, return monthly payment of 0.
        2. If APR is 0%, return monthly payment of:
           loan_amount / duration_months
        3. If loan duration is 0, return monthly payment of loan_amount.
           This means immediately paying off the entire loan.
=end


require 'yaml'
MESSAGES = YAML.load_file 'loan_calculator_messages.yml'

def prompt(message)
  puts "=> #{message}"
end

def float?(num_str)
  Float(num_str, exception: false)
end

# With the provided message, prompts the user to enter a number
# Accepts a string representation of an integer or float.
# Returns a non-negative float since all calculations use floats.
def input_num(prompt_msg='')
  input_str = ''
  loop do
    prompt prompt_msg
    input_str = gets.chomp
    if float?(input_str)
      break if input_str.to_f >= 0
      prompt MESSAGES['require_nonnegative']
    else
      prompt MESSAGES['invalid_input']
    end
  end
  input_str.to_f
end

system "clear"
prompt MESSAGES['welcome']

loop do
  loan_amount = input_num(MESSAGES['loan_amount'])
  rate_annual = input_num(MESSAGES['rate_annual'])
  prompt MESSAGES['input_duration']
  input_duration_years = input_num(MESSAGES['input_years'])
  input_duration_months = input_num(MESSAGES['input_months'])

  duration_months = input_duration_years * 12 + input_duration_months
  rate_monthly = rate_annual / 100 / 12

  # Handle input values of zero.
  if loan_amount == 0
    payment_monthly = 0
  # Interest-free loan. Avoids NaN error in Normal scenario calculation.
  elsif rate_annual == 0
    payment_monthly = loan_amount / duration_months
  # Immediate payment of entire loan amount
  elsif duration_months == 0
    payment_monthly = loan_amount
  # Normal scenario
  else
    payment_monthly = loan_amount *
                      (rate_monthly /
                        (1 - (1 + rate_monthly)**(-duration_months))
                      )
  end

  puts "Monthly payment: $#{format('%.2f', payment_monthly)}"

  prompt MESSAGES['another_calc']
  another = gets.chomp
  break unless %w(y yes).include?(another.downcase)
  system "clear"
end

prompt MESSAGES['thanks']
