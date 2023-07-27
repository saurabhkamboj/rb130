# By Launch School
def reduce(array, default=0)
  counter = 0
  accumulator = default

  while counter < array.size
    accumulator = yield(accumulator, array[counter])
    counter += 1
  end

  accumulator
end

# Further exploration
def reduce(array, accumulator=nil)
  index_counter = accumulator.nil? ? 1 : 0
  accumulator = accumulator.nil? ? array[0] : accumulator
  result = 0

  while index_counter < array.size
    result = yield(accumulator, array[index_counter])
    index_counter += 1
    accumulator = result
  end

  result
end

array = [1, 2, 3, 4, 5]

puts (reduce(array) { |acc, num| acc + num })                # => 15
puts (reduce(array, 10) { |acc, num| acc + num })            # => 25
# puts (reduce(array) { |acc, num| acc + num if num.odd? })    # => NoMethodError: undefined method `+' for nil:NilClass

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']
