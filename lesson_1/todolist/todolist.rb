# Todo class represents a to-do item, it's
# properties are; name, description and 'done'
# which is a flag to show if an item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(other_todo)
    self.title == other_todo.title &&
      self.description == other_todo.description &&
      self.done == other_todo.done
  end
end

# The class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a Todo object, including iteration & selection.

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo_object)
    if todo_object.instance_of? Todo
      todos << todo_object
    else
      raise TypeError, "Can only add Todo objects."
    end
  end
  alias :<< :add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos.clone
  end

  def done?
    todos.all? { |todo| todo.done? }
  end

  def item_at(index)
    todos.fetch(index)
  end

  def mark_done_at(index)
    todos.fetch(index).done!
  end

  def mark_undone_at(index)
    todos.fetch(index).undone!
  end

  def done!
    todos.each_index { |index| mark_done_at(index) }
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    todos.delete(item_at(index))
  end

  def to_s
    text = "---- #{title} ----\n"
    text << todos.map(&:to_s).join("\n")
    text
  end

  def each
    size.times do |index_counter|
      yield(todos[index_counter])
    end

    self
  end

  def select
    result = TodoList.new(title)

    self.each do |todo|
      result << todo if yield(todo)
    end

    result
  end

  # takes a string as argument, and returns the
  # first Todo object that matches the argument.
  # Return nil if no todo is found.
  def find_by_title(string)
    select { |todo| todo.title == string }.first
  end

  # returns new TodoList object containing only
  # the done items.
  def all_done
    select { |todo| todo.done? }
  end

  # returns new TodoList object containing only
  # the not done items
  def all_not_done
    select { |todo| todo.done? == false }
  end

  # takes a string as argument, and marks the first
  # Todo object that matches the argument as done.
  def mark_done(string)
    find_by_title(string) && find_by_title(string).done!
  end

  # mark every todo as done
  def mark_all_done
    each { |todo| todo.done! }
  end

  # mark every todo as not done
  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

# Alternate for TodoList#each
# def each
#   @todos.each do |todo|
#     yield(todo)
#   end
# end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

p list.find_by_title('A title')
p list.all_done
p list.all_not_done
puts list
