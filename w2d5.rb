class LRUCache
  def initialize(size)
    @size = size
    @hash = Hash.new
    @head = ListNode.new(:head)
    @tail = ListNode.new(:tail)
    @head.child = @tail
    @tail.parent = @head
  end

  def count
    # returns number of elements currently in cache
    @hash.count
  end

  def add(el)
   # adds element to cache according to LRU principle
    adder = ListNode.new(el)
    @hash[el] = adder
    adder.child = @head.child
    @head.child = adder
    adder.parent = @head
    adder.child.parent = adder

    if @hash.count > @size
      node_to_delete = @tail.parent
      name_to_delete = @tail.parent.value
      new_last = node_to_delete.parent
      new_last.child = @tail
      @tail.parent = new_last
      @hash.delete(name_to_delete)
    end
  end

  def show
    @hash.each{|h,v| p v.value}
  end

  private
  # helper methods go here!

end

class ListNode
  attr_accessor :value, :parent, :child

  def initialize(value, parent=nil, child=nil)
    @value, @parent, @child = value, parent, parent
  end

end

johnny_cache = LRUCache.new(4)

johnny_cache.add("I walk the line")
johnny_cache.add(5)

johnny_cache.count # => returns 2

johnny_cache.add([1,2,3])
johnny_cache.add(5)
johnny_cache.add(-5)
johnny_cache.add({a: 1, b: 2, c: 3})
johnny_cache.add([1,2,3,4])
johnny_cache.add("I walk the line")
johnny_cache.add(:ring_of_fire)
johnny_cache.add("I walk the line")
johnny_cache.add({a: 1, b: 2, c: 3})

johnny_cache.show
