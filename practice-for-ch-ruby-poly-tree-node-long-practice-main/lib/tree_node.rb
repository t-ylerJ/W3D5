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
    # tell parent that you're no longer part of it's children array, if you have a parent
    # @parent.children.delete(self) if @parent
    if @parent != nil
       @parent.children.select! { |child| child != self } 
    end
    
    # set new parent of self
    @parent = parent 
    # IMPORTANT NOTE: don't do this as an instance method to set the instance variable, you can set the instance variable 
    # directly. Otherwise you will run an infinite loop, because you are currently creating an instance method of parent= here
    # self.parent = new_parent 

    # add yourself to that parent's children array (can only do this if you have a parent and you aren't already in that children array)
    @parent.children << self if @parent && !@parent.children.include?(self)

    # @parent.children << self if !parent.nil?
   
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
    # check to see if self has value
    return self if self.value == target_value
    
    # if not self, move on to the children 
    self.children.each do |child|
      temp = child.dfs(target_value)
      return temp if temp # by putting in return in loop, you can end loop early if you find value 
    end

    nil 

    # OLD CODE 
    # return self.children[0] if self.children[0].value == target_value
    # self.dfs(target_value) 

  end

  # we want to use a queue for this 
  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end 
    nil
  end

end
 
 test_node = PolyTreeNode.new(5)
 parent_node = PolyTreeNode.new(10)
#  test_node.parent = parent_node
 p test_node

