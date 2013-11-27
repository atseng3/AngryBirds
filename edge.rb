class Edge
  attr_accessor :from_vertex, :to_vertex, :value
  
  def initialize(from_vertex, value, to_vertex = nil)
    @from_vertex = from_vertex
    @value = value
    @to_vertex = to_vertex
  end
end