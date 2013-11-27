require_relative 'tree_node'

class AngryBirdFlight
  attr_accessor :all_streams
  
  def initialize
    @all_streams = []
    @jetstreams = File.readlines("jetstreams.txt")
    @constant_energy = @jetstreams.shift.chomp.to_i
    @dest = 0
    @end_nodes = []
    make_nodes
  end
  
  def make_nodes 
    @jetstreams.each do |stream|
      each_stream = stream.chomp.split(" ")
      
      start_point = each_stream.shift.to_i
      end_point = each_stream.shift.to_i
      value = each_stream.shift.to_i
      
      
      @dest = end_point if end_point > @dest
      
      @all_streams << TreeNode2.new(start_point, end_point, value)
    end
    
    start = 0
    until start >= @dest
      @all_streams << TreeNode2.new(start, start + 1, @constant_energy)
      start += 1
    end
    @all_streams.sort_by! { |node| node.start_point }
    
    # root_node = @all_streams.first
    # visited_squares = [root_node.start_point, root_node.end_point]
    
    # nodes = [root_node]
    # until nodes.empty?
    #   current_node = nodes.shift
    #   current_pos = [current_node.start_point, current_node.end_point]
    #   
    #   valid_moves(current_pos).each do |next_pos|
    #     next if visited_squares.include?(next_pos)
    # 
    #     next_node = PolyTreeNode.new(next_pos)
    #     current_node.add_child(next_node)
    # 
    #     visited_squares << next_pos
    #     nodes << next_node
    #   end
    # end
  end

  def traverse 
    current_point = 1
    # minimum = @dest * @constant_energy
    current_energy = current_point * @constant_energy
    until current_point >= @dest
      stream = @all_streams.shift
      incoming_streams = @all_streams.select { |other_stream| other_stream.end_point == stream.start_point }
      incoming_streams.each do |other_stream|
        if other_stream.optimum_energy.nil?
          other_stream.optimum_energy = 
        else
          if other_stream.optimum_energy < current_energy
            current_energy = other_stream.optimum_energy
          end
        end

        if other_stream.value < minimum
          minimum = other_stream.value
        end
      end
      if stream.value < 
      current_point = stream.end_point
    end
  end

  # minimum = @dest * @constant_energy
  # final_path = []
  # @end_nodes.each do |end_node|
  #   # sum = 0 if end_node is 24
  #   # sum = (24 - 22) * 50 if end_node is 22 (or other num)
  #   sum = end_node.end_point == @dest ? 0 : (@dest - end_node.end_point) * @constant_energy
  # 
  #   nodes = []
  #   current_node = end_node
  #   until current_node.parent.nil?
  #     sum = sum + current_node.value + current_node.displacement
  #     nodes.unshift([current_node.start_point, current_node.end_point])
  #     current_node = current_node.parent
  #   end
  #   
  #   if sum < minimum
  #     minimum = sum
  #     final_path = nodes
  #   end
  # end
  # [minimum, final_path]



end


if __FILE__ == $PROGRAM_NAME
  a1 = AngryBirdFlight.new
  # find shortest path
  # p a1.shortest_path
  p a1.all_streams
end