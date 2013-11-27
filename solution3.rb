require_relative 'vertex'
require_relative 'edge'

class AngryBirdFlight
  attr_accessor :vertices
  
  def initialize
    @edges = []
    @vertices = []
    @jetstreams = File.readlines("jetstreams.txt")
    @constant_energy = @jetstreams.shift.chomp.to_i
    @dest = find_dest
  end
  
  # builds a Directed Acyclic Graph with vertices(each possible end point) 
  # and edges(each stream and each flight path). 
  
  # iterates through each possible end point and builds up the graph, 
  # at the same time calculating the optimum path to get to this potential 
  # end point. 
  def build_graph
    @vertices << Vertex.new(@constant_energy, 0)
    pos = 1
    until pos > @dest
      edges = find_edges(pos)
      current_vertex = Vertex.new(@constant_energy, pos, edges)
      current_vertex.in_edges.first.each do |edge| 
        if edge.to_vertex.nil?
          edge.to_vertex = current_vertex
          @edges << edge
        end
      end
      
      current_vertex.find_best_cost
      
      @vertices << current_vertex
      pos += 1
    end
    [@vertices.last.best_cost, @vertices.last.best_path]
  end
  
  # helper method to find the incoming edges to a vertex.
  def find_edges(pos)
    edges = []
    @jetstreams.each do |stream|
      each_stream = stream.chomp.split(" ")
      start_point = each_stream.shift.to_i
      end_point = each_stream.shift.to_i
      value = each_stream.shift.to_i
      
      # if a stream's end_point matches the current position, then make a new edge from this stream.
      if end_point == pos
        
        edges << Edge.new(find_vertex(start_point), value)

      end
    end
    
    if @vertices.empty?
      # adds a new edge with a new vertex on initialization. -- only happens once
      edges << Edge.new(Vertex.new(@constant_energy, pos - 1), @constant_energy)
    else
      # adds a new edge that comes from the previous vertex. ie. adds 1 2 50. 
      edges << Edge.new(@vertices.find { |vertex| vertex.pos == (pos - 1) }, @constant_energy)
    end
  end
  
  # helper method to find the vertex of a given point. 
  def find_vertex(pos)
    @vertices.select { |vertex| vertex.pos == pos }.first
  end
  
  # loops through jetstreams to find the destination.
  def find_dest
    dest = 0
    @jetstreams.each do |stream|
      each_stream = stream.chomp.split(" ")
      end_point = each_stream[1].to_i
      
      dest = end_point if end_point > dest
    end
    dest
  end
end


if __FILE__ == $PROGRAM_NAME
  start_time = Time.now
  a1 = AngryBirdFlight.new
  p a1.build_graph
  p "Run time: " + ((Time.now - start_time) * 1000).to_s
end