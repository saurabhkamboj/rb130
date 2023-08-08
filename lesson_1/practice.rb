# 1
def message(string)
  yield
  string
end

message("hi") { puts "hello" }

# 2
def message(string)
  yield # shows a LocalJumpError
  string
end

# 3
def message(string)
  yield if block_given? # solves for LocalJumpError
  string
end

message("jello")

# 4
def better_message(string)
  if block_given?
    yield(string)
  end
  string
end

better_message("hello") do |string|
  puts string + ", how are you?"
end

# 5
def time_taken
  time_before = Time.now
  yield
  time_after = Time.now

  puts time_after - time_before
end

time_taken { puts "Hello" }

# 6
CONSTANT = 'works'

module Vanilla
  CONSTANT = "Here"
  class Cake
    def resolve_constant
      CONSTANT
    end
  end

  class Cupcake
    def resolve_constant
      Vanilla::Cake::CONSTANT
    end
  end
end

p Vanilla::Cake.new.resolve_constant # "Here"
p Vanilla::Cupcake.new.resolve_constant 

# 7
def call_me(some_code)
  some_code.call # call will execute the "chunk of code" that gets passed in
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"} # 'Proc' object

call_me(chunk_of_code)

# 8
[1, 2, 3, 4, 5].map(&:to_s).map(&:to_i) # => [1, 2, 3, 4, 5]

["hello", "world"].each(&:upcase!) # => ["HELLO", "WORLD"]
[1, 2, 3, 4, 5].select(&:odd?) # => [1, 3, 5]
[1, 2, 3, 4, 5].select(&:odd?).any?(&:even?) # => false
