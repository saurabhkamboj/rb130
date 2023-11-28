require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    todo = @list.shift
    assert_equal(@todo1, todo)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done
    assert_equal(false, @list.done?)

    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_type_error # Launch school named this method test_add_raise_error
    assert_raises(TypeError) { @list.add("Buy pencils") } # Can add more lines to test assertions for other object types.
  end

  def test_shovel_method
    todo = Todo.new("Buy Kaashi ka Assi")
    @todos << todo
    @list << todo

    assert_equal(@todos, @list.to_a)
  end

  def test_shovel_alias
    new_todo = Todo.new("Buy Kaashi ka Assi")
    @todos << new_todo
    @list.add(new_todo)

    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) { @list.item_at(4) }
    assert_equal(@todo1, @list.item_at(0))
  end

  def test_mark_done
    @list.mark_done("Buy milk")
    assert_equal(true, @list.find_by_title("Buy milk").done?)
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(10) }

    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(10) }

    @list.mark_all_done
    @list.mark_undone_at(0)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo1.done?)
  end

  def test_done
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_remove_at # Copied from Launch school
    assert_raises(IndexError) { @list.remove_at(100) }

    @list.remove_at(1)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s2
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    @list.mark_done_at(0)
    assert_equal(output, @list.to_s)
  end

  def test_to_s3
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    test_array = []
    @list.each { |todo| test_array << todo }

    assert_equal(@list.to_a, test_array)
  end

  def test_each_returns_original_list
    assert_equal(@list, @list.each {})
  end

  def test_select # Code by Launch School also tests if the titles of the lists are same
    @todo1.done!
    test_array = @list.select { |todo| todo.done? }

    assert_equal([@todo1], test_array.to_a)
  end

  def test_map
    @list.mark_all_done
    test_array = @list.map(&:done?)

    assert_equal(true, test_array.all?(true))
  end

  def test_mark_all_undone
    @list.mark_all_undone

    assert_equal(true, @list.map(&:done?).all?(false))
  end
end
