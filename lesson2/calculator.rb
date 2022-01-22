=begin
PEDAC

Understand the Problem
-----------------------
Problem Statement:
Build a command line calculator program that does the following:
- Asks for two numbers.
- Asks for the type of operation to perform: add, subtract, multiply or divide.
- Displays the result.
Use the Kernel.gets() method to retrieve user input, and use Kernel.puts() 
method to display output. Remember that Kernel.gets() includes the newline, so 
you have to call chomp() to remove it: Kernel.gets().chomp().

Inputs:
- Two numbers, input by the user using Kernel.gets().chomp().
- A String representing the type of operation, input by the user.

Outputs:
- Print out one number using Kernel.puts().
  This number is result of the operation performed on the two inputs.

Problem Domain:
- If the numbers are both integers, is integer division expected? 
  - No; calculators force float division.

Implicit Requirements:
- The problem does not specify the allowable number types. I will assume the 
  calculator can accept Integer and Floats. No complex numbers.
- The operation is entered as a string.
- The first input is on the left side of the operator.
- DO NOT use integer division since it is not the normal behavior of a 
  calculator.

Clarifying Questions:
- Maximum allowed value? Do we need to handle extremely large numbers?
- What happens if one or both of the numbers, or the operation type is not 
  provided?
  - The user should be re-prompted to enter the input. No default values will 
    be used.

Mental Model:
- Ask the user for the two numbers and the operation type.
- Convert string inputs to number types, with validation.
- Ask the user for the operation type.
- Validate the operation type using a non-case-sensitive method.
- Using the Ruby method that corresponds to each of the four operations, 
  perform this operation on the two inputs.
- Print the result to the screen.


Examples, Test Cases, and Edge Cases
-----------------------
Example 1 - Basic Addition with Integers
Inputs: 5, 2, add
Outputs: 7

Example 2 - Basic Addition with at least 1 Float
Inputs: 5.0, 2, add
Outputs: 7.0

Example 3 - Basic Subtraction with Integers
Inputs: 5, 2, subtract
Outputs: 3

Example 4 - Basic Subtraction with at least 1 Float
Inputs: 5.0, 2, subtract
Outputs: 3.0

Example 5 - Basic Multiplication with Integers
Inputs: 5, 2, multiply
Outputs: 10

Example 6 - Basic Multiplication with at least 1 Float
Inputs: 5, 2, multiply
Outputs: 10

Example 7 - Basic Division with Integers (no integer division)
Inputs: 5, 2, divide
Outputs: 2.5

Example 8 - Basic Division with at least 1 Float
Inputs: 5.0, 2, divide
Outputs: 2.5

Example 9 - Divide by Zero
Inputs: 1, 0, divide
Outputs: Re-prompt the user for all input, to avoid ZeroDivision error.

Example 10 - Unacceptable Input Numbers
Inputs for numbers: String that does not evaluate to a number including: 
nil, null, empty input, [], {}
Outputs: Re-prompt the user for number input.

Example 11 - Unacceptable Operation Type
Inputs for operation: "square", "", "abcdefg"
Outputs: Re-prompt the user for operation type.

Test Cases:

Edge Cases:


Data Structure
-----------------------
Numbers: Collect as string, convert to float.
Operation type: Collect as string.


Algorithm
-----------------------
- Create a method called `calculator` with no parameters.
- For each of the two number inputs, set up a do/while loop asking for input.
- Use `gets().chomp()` to store these strings in variables.
- Perform validation checks on the inputs to ensure they are not empty and can 
  be successfully type-converted to floats. If not validated, re-query the user 
  for an input.
- Convert the inputs into floats using the method.
- Set up a do/while loop to ask the user for the operation type.
- Use `gets().chomp()` and store this string in a variable.
- Create case/when expression to determine which operation to perform.
- Assign the result of the case expression to a result variable.
- Print the value of `result` to the screen, using Kernel.puts().


Code
-----------------------
=end

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def integer?(number_string)
  !!Integer(number_string, exception: false)
end

def float?(number_string)
  !!Float(number_string, exception: false)
end

def operation_to_message(op)
  word = case op
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         when '4'
           'Dividing'
         end
  word
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end
prompt("Hi #{name}!")

loop do
  number1 = ''
  loop do
    prompt(MESSAGES['first_num'])
    number1 = Kernel.gets().chomp()
    if integer?(number1) || float?(number1)
      break
    else
      prompt(MESSAGES['invalid_input'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['second_num'])
    number2 = Kernel.gets().chomp()
    if integer?(number2) || float?(number2)
      break
    else
      prompt(MESSAGES['invalid_input'])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['select_op'])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_f() + number2.to_f()
           when '2'
             number1.to_f() - number2.to_f()
           when '3'
             number1.to_f() * number2.to_f()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt(result)

  prompt(MESSAGES['another_calc'])
  another = Kernel.gets().chomp()
  break unless another.downcase().start_with?('y')
end

prompt(MESSAGES['thanks'])
