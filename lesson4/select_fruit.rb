produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(produce)
  selected_fruit = {}
  keys = produce.keys
  counter = 0

  loop do
    break if counter == keys.length

    current_produce = keys[counter]
    current_value = produce[current_produce]

    if current_value == 'Fruit'
      selected_fruit[current_produce] = current_value
    end

    counter += 1
  end

  selected_fruit
end

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}