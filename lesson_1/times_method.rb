def times(number)
  counter = 0

  # times method passes numbers starting
  # from 0 to 1 less than the number passed
  # in as an argument to the methods invocation.
  while counter < number

    # we yield to the block here and pass
    # the object referenced by counter as
    # an argument to the yielded block.
    yield(counter)
    counter += 1
  end

  # `#times` returns the calling object
  # therefore number is returned once the
  # expressions within the method definition
  # are executed.
  number
end

5.times do |number|
  puts number
end
