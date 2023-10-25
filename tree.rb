require_relative "node"

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    # Eliminamos duplicados y ordenamos el array
    sorted_array = array.uniq.sort
    return create_tree(sorted_array, 0, sorted_array.length - 1)
  end

  def create_tree(array, start_idx, end_idx)
    return nil if start_idx > end_idx

    mid_idx = (start_idx + end_idx) / 2
    root = Node.new(array[mid_idx])

    root.left = create_tree(array, start_idx, mid_idx - 1)
    root.right = create_tree(array, mid_idx + 1, end_idx)

    root
  end

  # Dentro de la clase Tree
  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end

    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      node.data = min_value_node(node.right).data
      node.right = delete(node.data, node.right)
    end

    node
  end

  def min_value_node(node)
    current = node
    current = current.left while current.left
    current
  end

  # Dentro de la clase Tree
  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  # Dentro de la clase Tree
  def level_order(node = @root, &block)
    return if node.nil?

    queue = []
    values = []
    queue.push(node)

    until queue.empty?
      current = queue.shift
      block_given? ? yield(current) : values << current.data

      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
    end

    values unless block_given?
  end

  # Dentro de la clase Tree
  def inorder(node = @root, &block)
    values = []
    return values if node.nil?

    values.concat(inorder(node.left, &block))
    block_given? ? yield(node) : values << node.data
    values.concat(inorder(node.right, &block))

    values
  end

  def preorder(node = @root, &block)
    values = []
    return values if node.nil?

    block_given? ? yield(node) : values << node.data
    values.concat(preorder(node.left, &block))
    values.concat(preorder(node.right, &block))

    values
  end

  def postorder(node = @root, &block)
    values = []
    return values if node.nil?

    values.concat(postorder(node.left, &block))
    values.concat(postorder(node.right, &block))
    block_given? ? yield(node) : values << node.data

    values
  end

  # Dentro de la clase Tree
  def height(node)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node, root = @root)
    return 0 if node == root

    if node.data < root.data
      1 + depth(node, root.left)
    else
      1 + depth(node, root.right)
    end
  end

  # Dentro de la clase Tree
  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    values = level_order
    @root = build_tree(values)
  end
end
