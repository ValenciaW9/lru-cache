class Node {
  constructor(data = null, key = null, next = null, prev = null) {
    this.data = data;
    this.key = key;
    this.next = next;
    this.prev = prev;
  }
}

class DoublyLinkedList {
  constructor(head = null, tail = null) {
    this.head = head;
    this.tail = tail;
  }

  addHead(node) {
    // Add the given node to the head of the list
    if (!this.head) {
      this.head = node;
      this.tail = node;
    } else {
      node.next = this.head;
      this.head.prev = node;
      this.head = node;
    }
  }

  removeTail() {
    // Remove the tail node from the list and return it
    if (!this.tail) {
      return null;
    } else {
      const tailNode = this.tail;
      if (this.head === this.tail) {
        this.head = null;
        this.tail = null;
      } else {
        this.tail.prev.next = null;
        this.tail = this.tail.prev;
      }
      return tailNode;
    }
  }

  removeNode(node) {
    // Remove the given node from the list and return it
    if (!node) {
      return;
    }

    if (node === this.head) {
      if (this.head === this.tail) {
        this.head = null;
        this.tail = null;
      } else {
        this.head = this.head.next;
        this.head.prev = null;
      }
    } else if (node === this.tail) {
      this.tail = this.tail.prev;
      this.tail.next = null;
    } else {
      node.prev.next = node.next;
      node.next.prev = node.prev;
    }

    node.next = null;
    node.prev = null;
  }

  moveNodeToHead(node) {
    // Move the given node from its location to the head of the list
    if (node === this.head) {
      return;
    }

    this.removeNode(node);
    this.addHead(node);
  }
}

class LRUCache {
  constructor(limit = 10) {
    this.limit = limit;
    this.size = 0;
    this.hash = {};
    this.list = new DoublyLinkedList(limit);
  }

  get(key) {
    // Retrieve the node from the cache using the key
    // If the node is in the cache, move it to the head of the list and return it
    // Otherwise, return -1
    if (this.hash[key]) {
      const node = this.hash[key];
      this.list.moveNodeToHead(node);
      return node.data;
    } else {
      return -1;
    }
  }

  put(key, value) {
    // Add the given key and value to the cache
    // If the cache already contains the key, update its value and move it to the head of the list
    // If the cache doesn't contain the key, add it to the cache and place it at the head of the list
    // If the cache is full, remove the least recently used item before adding the new data to the cache
    if (this.hash[key]) {
      const node = this.hash[key];
      node.data = value;
      this.list.moveNodeToHead(node);
    } else {
      const newNode = new Node(value, key);
      this.hash[key] = newNode;
      this.list.addHead(newNode);
      this.size++;

      if (this.size > this.limit) {
        const tailNode = this.list.removeTail();
        delete this.hash[tailNode.key];
        this.size--;
      }
    }
  }
}

if (require.main === module) {
  // Add your own tests here
}

module.exports = {
  Node,
  DoublyLinkedList,
  LRUCache
};
Pseudocode for moveNodeToHead method:
```
moveNodeToHead(node):
if node is equal to the head:
return

removeNode(node)
addHead(node)

//Explanation:
In the `LRUCache` class, the `get` method retrieves the node from the cache using the key. If the node is in the cache, it moves the node to the head of the list using the `moveNodeToHead` method and returns its data. If the node is not in the cache, it returns -1.

The `put` method adds the given key and value to the cache. If the cache already contains the key, it updates the value and moves the corresponding node to the head of the list. If the cache does not contain the key, it adds the key-value pair to the cache and places it at the head of the list. If the cache is full, it removes the least recently used item by calling the `removeTail` method before adding the new data to the cache.

This implementation allows efficient access to the most recently used items by keeping them at the head of the list, while removing the least recently used items when the cache is full.
