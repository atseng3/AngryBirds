# the Edge class keeps track of in_vertex, out_vertex, the weight of the edge, and the type
class Edge
  attr_reader :out_vertex, :in_vertex, :value, :type
  
  def initialize(out_vertex, in_vertex, value, type)
    @out_vertex, @in_vertex, @value, @type =
      out_vertex, in_vertex, value, type

      # on initialization a new instance of an edge will push itself 
      # into its corresponding vertices' edges array
    out_vertex.out_edges << self
    in_vertex.in_edges << self
  end
end