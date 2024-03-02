class Node
  attr_accessor :data, :key, :next_node, :prev_node

  def initialize(data = nil, key = nil, next_node = nil, prev_node = nil)
    @data = data
    @key = key
    @next_node = next_node
    @prev_node = prev_node
  end
end

class DoublyLinkedList
  attr_reader :head, :tail

  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
  end

  # ADD THE NODE TO THE HEAD OF THE LIST
  def add_head(node) 
    # Add the given node to the head of the list
    if @head.nil?
      @head = node
      @tail = node
    else
      node.next_node = @head
      @head.prev_node = node
      @head = node
    end
  end

  # REMOVE THE TAIL NODE FROM THE LIST
  # AND RETURN IT
  def remove_tail
    # Remove the tail node from the list and return it
    if @tail.nil?
      return nil
    else
      tail_node = @tail
      if @head == @tail
        @head = nil
        @tail = nil
      else
        @tail.prev_node.next_node = nil
        @tail = @tail.prev_node
      end
      return tail_node
    end
  end

  # REMOVE THE GIVEN NODE FROM THE LIST
  # AND THEN RETURN IT
  def remove_node(node) 
    # Remove the given node from the list and return it
    return if node.nil?

    if node == @head
      if @head == @tail
        @head = nil
        @tail = nil
      else
        @head = @head.next_node
        @head.prev_node = nil
      end
    elsif node == @tail
      @tail = @tail.prev_node
      @tail.next_node = nil
    else
      node.prev_node.next_node = node.next_node
      node.next_node.prev_node = node.prev_node
    end

    node.next_node = nil
    node.prev_node = nil
  end

  # MOVE THE GIVEN NODE FROM ITS LOCATION TO THE HEAD
  # OF THE LIST
  def move_node_to_head(node) 
    # Move the given node from its location to the head of the list
    return if node == @head

    remove_node(node)
    add_head(node)
  end
end

class LRUCache
  attr_reader :limit, :size

  def initialize(limit = 10)
    @limit = limit
    @size = 0
    @hash = {}
    @list = DoublyLinkedList.new
  end

  # RETRIEVE THE NODE FROM THE CACHE USING THE KEY
  # IF THE NODE IS IN THE CACHE, MOVE IT TO THE HEAD OF THE LIST AND RETURN IT
  # OTHERWISE RETURN -1
  def get(key)
    if @hash[key]
      node = @hash[key]
      @list.move_node_to_head(node)
      return node.data
    else
      return -1
    end
  end

  # ADD THE GIVEN KEY AND VALUE TO THE CACHE
  # IF THE CACHE ALREADY CONTAINS THE KEY, UPDATE ITS VALUE AND MOVE IT TO 
  # THE HEAD OF THE LIST
  # IF THE CACHE DOESN'T CONTAIN THE KEY, ADD IT TO THE CACHE AND PLACE IT
  # AT THE HEAD OF THE LIST
  # IF THE CACHE IS FULL, REMOVE THE LEAST RECENTLY USED ITEM BEFORE ADDING
  # THE NEW DATA TO THE CACHE
  def put(key, value)
    if @hash[key]
      node = @hash[key]
      node.data = value
      @list.move_node_to_head(node)
    else
      new_node = Node.new(value, key)
      @hash[key] = new_node
      @list.add_head(new_node)
      @size += 1

      if @size > @limit
        tail_node = @list.remove_tail
        @hash.delete(tail_node.key)
        @size -= 1
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  # Add your own tests here
end
Pseudocode for move_node_to_head method:
```
movenodeto_head(node):
if node is equal to the head:
return

remove_node(node)
add_head(node)

Explanation:
The `move_node_to_head` method in the `DoublyLinkedList` class moves a given node to the head of the list. It first checks if the given node is already the head. If it is, there is no need to move it, so the method returns early. Otherwise, it removes the node from its current position in the list by calling the `remove_node` method. Then, it adds the node to the head of the list by calling the `add_head` method, making the moved node the new head of the list.

In the `LRUCache` class, the `get` method retrieves the node from the cache using the key. If the node is in the cache, it moves the node to the head of the list using the `move_node_to_head` method and returns its data. If the node is not in the cache, it returns -1.

The `put` method adds the given key and value to the cache. If the cache already contains the key, it updates the value and moves the corresponding node to the head of the list. If the cache does not contain the key, it adds the key-value pair to the cache and places it at the head of the list. If the cache is full, it removes the least recently used item by calling the `remove_tail` method before adding the new data to the cache.

This implementation allows efficient access to the most recently used items by keeping them at the head of the list, while removing the least recently used items when the cache is full.