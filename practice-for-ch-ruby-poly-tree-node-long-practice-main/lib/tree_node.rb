require "byebug"

class PolyTreeNode
  attr_reader :parent, :children, :value
  
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end
  
  # set current node(self) parent to a new parent
  def parent=(parent)

    if @parent != nil
       @parent.children.select! { |child| child != self } 
    end
    @parent = parent 
    @parent.children << self if !parent.nil?
   
  end


  def add_child(child_node)
    child_node.parent= self     
    self.children << child_node if self.children.none? { |child| child == child_node }

  end

  def remove_child(child_node)
    raise "node is not a child" if !self.children.include?(child_node) 

    self.children.map! do |child|    
      if child = child_node 
        child_node.parent = nil 
      end
    end

  end

  def dfs(target_value)
    return self.children[0] if self.children[0].value == target_value
    self.dfs(target_value) 

  end

end
 
 test_node = PolyTreeNode.new(5)
 parent_node = PolyTreeNode.new(10)
#  test_node.parent = parent_node
 p test_node

