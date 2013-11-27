class TreeNode
  attr_accessor :children, :parent, :value, :start_point, :end_point, :displacement, :energy
  
  def initialize(start_point, end_point, value)
    @start_point = start_point
    @end_point = end_point
    @value = value
    @children = []
    @parent = nil
    @displacement = 0
  end
  
  def set_parent(parent)
    @parent = parent
    if !self.parent.children.include?(self)
      self.parent.children << self
    end
  end
  
  def add_child(new_child)
    @children << new_child
    new_child.parent = self
  end
  
  def path
    return [[self.start_point, self.end_point]] if self.parent.nil?
    self.parent.path << [self.start_point, self.end_point]
  end
end