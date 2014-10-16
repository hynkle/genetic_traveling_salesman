You are to implement a genetic algorithm finding solutions to the Traveling
Salesman Problem.

Visualize the problem as a set of points on a plane.  Your "salesman" must visit
all of these points, but obviously wants to minimize the distance he has to
travel and so must choose the order of his visits carefully.

Your solution, then, is list of all n nodes in the order they should be visited.
Your solution's score is the summed distance between consecutive nodes of your
solution, *including* from the last node back to the first.  (Since his route
is closed, there is no constraint as to which node he starts or finishes at.)

You may use any genetic exchange and mutation strategy.

In this directory is a file `TSPDATA.txt` containing the name of each node
(numbered 1–127 in this case) and its Cartesian coordinates on a Euclidean
plane.
