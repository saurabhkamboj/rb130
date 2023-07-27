def select(array)
  counter = 0
  result = []

  while counter < array.size
    result << array[counter] if yield(array[counter])
    counter += 1
  end

  result
end

# Alternate
def select(array)
  result = []

  for current_element in array
    result << current_element if yield(current_element)
  end

  result
end

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true
