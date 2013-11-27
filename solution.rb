require_relative 'tree_node'

class AngryBirdFlight
  
  def initialize
    @all_streams = [TreeNode.new(0, 0, 0)]
    @jetstreams = File.readlines("jetstreams.txt")
    @constant_energy = @jetstreams.shift.chomp.to_i
    @dest = 0
    @end_nodes = []
    make_nodes
    build_tree
  end
  
  # bfs
  def shortest_path
    minimum = @dest * @constant_energy
    final_path = []
    @end_nodes.each do |end_node|
      # sum = 0 if end_node is 24
      # sum = (24 - 22) * 50 if end_node is 22 (or other num)
      sum = end_node.end_point == @dest ? 0 : (@dest - end_node.end_point) * @constant_energy

      nodes = []
      current_node = end_node
      until current_node.parent.nil?
        sum = sum + current_node.value + current_node.displacement
        nodes.unshift([current_node.start_point, current_node.end_point])
        current_node = current_node.parent
      end
      
      if sum < minimum
        minimum = sum
        final_path = nodes
      end
    end
    [minimum, final_path]
  end
  
  # create nodes out of each stream. 
  def make_nodes
    @jetstreams.each do |stream|
      each_stream = stream.chomp.split(" ")
      
      start_point = each_stream.shift.to_i
      end_point = each_stream.shift.to_i
      value = each_stream.shift.to_i
    
      @dest = end_point if end_point > @dest
    
      @all_streams << TreeNode.new(start_point, end_point, value)
    end
  end
  
  # bfs
  def build_tree
    nodes = [@all_streams.first]
    until nodes.empty?
      current_node = nodes.shift
      
      current_start_point = current_node.start_point
      current_end_point = current_node.end_point
      
      children = valid_children(current_start_point, current_end_point)
      # detect and store an end_node
      @end_nodes << current_node if children.empty?
      
      children.each do |child|
        next_node = TreeNode.new(child.start_point, child.end_point, child.value)
        current_node.add_child(next_node)
        next_node.displacement = (next_node.start_point - current_node.end_point) * @constant_energy
        
        nodes << next_node
      end
    end
  end
  
  def valid_children(start_point, end_point)
    children = []
    @all_streams.each do |child|
      if !(start_point == child.start_point && end_point == child.end_point) && (child.start_point >= end_point)
        children << child
      end
    end
    children
  end
end


if __FILE__ == $PROGRAM_NAME
  start_time = Time.now
  a1 = AngryBirdFlight.new

  p a1.shortest_path
  p (Time.now - start_time) * 1000
end