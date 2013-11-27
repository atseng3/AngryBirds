class Vertex
  attr_accessor :pos, :in_edges, :best_cost, :best_path, :best_edge
  
  def initialize(constant_energy, pos, *in_edges)
    @constant_energy = constant_energy
    @pos = pos
    @in_edges = in_edges || []
    @best_path = [pos - 1, pos]
    @best_cost = pos * constant_energy
    @best_edge = nil
  end
  
  def find_best_cost
    unless @in_edges.first.nil?
      @in_edges.first.each do |edge|
        current_cost = edge.value + edge.from_vertex.best_cost
        if current_cost < @best_cost
          @best_cost = current_cost
          @best_path = [edge.from_vertex.pos, pos]
        end
        @best_edge = edge
      end
    end
  end
  
  def update_best_path
    previous_edge = @best_edge.bes_edge
    until previous_edge.nil?
      @best_path << [previous_edge.from_vertex.pos, pos]
    end
  end
end