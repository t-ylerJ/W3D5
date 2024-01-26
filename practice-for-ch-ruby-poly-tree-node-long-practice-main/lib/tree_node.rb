require "byebug"

class PolyTreeNode
  attr_reader :parent, :children, :value
  
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end
  
  def parent=(parent)

    if @parent != nil
       @parent.children.select! { |child| child != self } 
    end
    @parent = parent 
    @parent.children << self if !parent.nil?
   
  end




 
end
 
 test_node = PolyTreeNode.new(5)
 parent_node = PolyTreeNode.new(10)
#  test_node.parent = parent_node
 p test_node

