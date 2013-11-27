# Angry Birds Flight Path
There are 2 solutions to finding the optimum path that an angry bird can take to get to his destination while riding on jetstreams.

The solutions are written in Ruby, please run "ruby solution.rb" or "ruby solution3.rb" to see the results.

I have already added new stream to jetstreams.txt to test the functionality and run time but feel free to add more for even better visualization.

### Explanation
1st solution: My first solution is implemented with a class called AngryBirdFlight that handles parsing "jetstreams.txt", building a multi-children Tree, and searching through this tree for the optimum path. 

2nd solution: My second solution is also implemented with the same class but the algorithm is much different. This solution is done by building up a Directed Acyclic Graph. Starting from the origin, and iterating up via each potential end point, each flight path/jetstream coming in to this potential end point is evaluated and the optimum path is found. This is done all the way until the very last end point and in the end upon building the tree we have our solution. 

This solution greatly optimizes the time spent on calculation. 

To demonstrate this, I have added ~2.5X more inputs into "jetstreams.txt" and we can see the drastic improvement. 

The average run time for the Tree solution is ~120ms. 

The average run time for the DAG solution is ~2ms. 

