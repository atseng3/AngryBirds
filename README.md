# Angry Birds Flight Path

The solution is written in Ruby, please run "ruby solution.rb" to see the results. 

To see run time, please uncomment the last line of code. The unit is in microseconds. 

I have already added new stream to jetstreams.txt to test the functionality and run time but feel free to add more for even better visualization.

### Explanation
1st solution: My first solution is implemented with a class called AngryBirdFlight that handles parsing "jetstreams.txt", building a multi-children Tree, and searching through this tree for the optimum path. 

2nd solution: My second solution is also implemented with the same class but the algorithm is much different. This solution is done by building up a Directed Acyclic Graph. Starting from the origin, and iterating up via each potential end point, each flight path/jetstream coming in to this potential end point is evaluated and the optimum path is found. This is done all the way until the very last end point and in the end upon building the tree we have our solution. Solution runs ~60X better.

3rd solution: Optimized 2nd solution, set up slightly different methods and cleaned up Vertex class for much improved run time. By taking the path calculation out of the Vertex class I was able to make cleaner graph building methods. Current solution runs ~10X better.