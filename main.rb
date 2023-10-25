require_relative "tree"

def print_traversal(tree, method)
  puts "#{method.capitalize} traversal:"
  p tree.send(method)
end

# Create a binary search tree from an array of random numbers
tree = Tree.new(Array.new(15) { rand(1..100) })

# Confirm that the tree is balanced
puts "Is the tree balanced? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order
puts "Level order traversal:"
p tree.level_order
puts "Preorder traversal:"
p tree.preorder
puts "Postorder traversal:"
p tree.postorder
puts "Inorder traversal:"
p tree.inorder

# Unbalance the tree by adding several numbers > 100
[101, 102, 103, 104, 105].each { |num| tree.insert(num) }

# Confirm that the tree is unbalanced
puts "Is the tree balanced after adding numbers > 100? #{tree.balanced?}"

# Balance the tree
tree.rebalance

# Confirm that the tree is balanced
puts "Is the tree balanced after rebalancing? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order
puts "Level order traversal after rebalancing:"
p tree.level_order
puts "Preorder traversal after rebalancing:"
p tree.preorder
puts "Postorder traversal after rebalancing:"
p tree.postorder
puts "Inorder traversal after rebalancing:"
p tree.inorder
