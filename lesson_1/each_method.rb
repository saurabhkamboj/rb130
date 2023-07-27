def each(argument)
  index_counter = 0

  while index_counter < argument.size
    yield(argument[index_counter])
    index_counter += 1
  end

  argument
end

# Alternate
def each(argument)
  for i in argument
    yield(i)
  end

  argument
end

[1, 2, 3].each do |number|
  puts number
end
