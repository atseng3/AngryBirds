require 'debugger'
require_relative 'vertex'
require_relative 'edge'

class AngryBirdFlight
  attr_accessor :vertices, :stream_hash
  
  def initialize
    @vertices = []
    @jetstreams = File.readlines("jetstreams.txt")
    @constant_energy = @jetstreams.shift.chomp.to_i

    # two methods to build a Directed Acyclic Graph with vertices(each possible end point)
    # and edges(each stream and each flight path).
    parse
    add_default_edges
  end
  
  def parse
    vertices = {}
    
    # stores a hash of position, cost, previous vertex, and best_edge_type to a vertex.
    vertices[0] = Vertex.new({ pos: 0, cost: 0, prev: nil, edge: nil })

    @jetstreams.each do |stream|
      start_val, end_val, edge_cost = stream.split(" ")

      vertices[start_val.to_i] ||= Vertex.new({ pos: start_val.to_i })
      vertices[end_val.to_i] ||= Vertex.new({ pos: end_val.to_i })

      Edge.new(vertices[start_val.to_i], vertices[end_val.to_i], edge_cost.to_i, "jet")
    end
    
    # stores the resulting sorted vertices in @vertices as an array
    @vertices = vertices.values.sort_by { |vertex| vertex.value[:pos] }
  end
  
  # adds default edges to each vertex 
  
  def add_default_edges
    @vertices.each_index do |i|
      next if i == @vertices.length - 1
      from = @vertices[i]
      to = @vertices[i + 1]
      distance = (to.value[:pos] - from.value[:pos])
      Edge.new(from, to, @constant_energy * distance, "default")
    end
    @vertices
  end
  
  # iterates through each possible end point and calculates best cost.
  
  def calc_costs
    start_vertex, end_vertex = @vertices.first, @vertices.last
  
    @vertices.each do |vertex|
      best_cost = nil
      best_prev = nil
      best_edge_type = nil

      vertex.in_edges.each do |in_edge|
        prev_vertex = in_edge.out_vertex
        prev_cost = prev_vertex.value[:cost]

        next if prev_cost.nil?

        current_cost = prev_cost + in_edge.value

        if best_cost.nil? || current_cost < best_cost
          best_cost = current_cost
          best_prev = prev_vertex
          best_edge_type = in_edge.type
        end
      end
    
      if vertex.value[:pos] != 0
        vertex.value[:cost] = best_cost
        vertex.value[:prev] = best_prev
        vertex.value[:edge] = best_edge_type
      end
    end

    nil
  end
  
  # traverses backwards from the last vertex to find the total path.
  
  def best_path
    path = []

    vertex = @vertices.last
    until vertex.value[:pos] == 0
      prev_vertex = vertex.value[:prev]
      path.unshift([prev_vertex.value[:pos], vertex.value[:pos]]) if vertex.value[:edge] == "jet"
      vertex = prev_vertex
    end

    path
  end
end

if __FILE__ == $PROGRAM_NAME
  start_time = Time.now
  a1 = AngryBirdFlight.new
  a1.calc_costs
  dest_cost = a1.vertices.last.value[:cost]
  best_path = a1.best_path
  p [dest_cost, best_path]
  # p "Run time: " + ((Time.now - start_time) * 1000000).to_s
end