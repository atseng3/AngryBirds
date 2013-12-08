# the vertex class keeps track of the value of the vertex, 
# the incoming edges and the outgoing edges
class Vertex
  attr_reader :value, :in_edges, :out_edges
  
  def initialize(value)
    @value = value
    @in_edges, @out_edges = [], []
  end
end