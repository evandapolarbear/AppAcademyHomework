class Stack
  def initialize
    @stack = Array.new
  end

  def add(el)
    @stack.unshift(el)
  end

  def remove
    @stack.shift
  end

  def show
    p @stack
  end
end

class Queue
  def initialize
    @queue = Array.new
  end

  def add(el)
    @queue << el
  end

  def remove
    @queue.shift
  end

  def show
    p @queue
  end
end

class Map
  def initialize
    @map = Array.new
  end

  def assign(key, value)
    @map << [key, value] unless @map.any?{|el| el[0] == key}
  end

  def lookup(key)
    @map.find{|el| el[0] == key}
  end

  def remove(key)
    @map = @map.reject {|el| el[0] == key}
  end

  def show
    p @map
  end
end
