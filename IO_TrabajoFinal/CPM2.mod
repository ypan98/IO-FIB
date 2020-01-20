set Activities; # Real activities
set Final_Activity;  # Dummy activity to mark the end of the project, this set only has one element
set Nodes = Activities union Final_Activity;  # Nodes we are going to use in the LP formulation
set Arcs within (Nodes cross Nodes);  # Arcs that mark precedence relationship between activities

param completionTime {Nodes} default 0;  # Completion time associated to each activity
param executionCost {Nodes} default 0; # Execution cost associated to each activity
param crashCost {Nodes} default 0; # Crash cost associated to each activity
param crashCompletionTime {Nodes} default 0; # Completion time associated to each crashed activity
param directioningCost default 0; # Cost of directioning the project per time unit
param b0 default 10000000; # Budget we have for the whole project
param r default 0; # interest rate for a loan

param w default 0.5; # Due to that the objectives have different metric, we use weight to balance them.

check {i in Activities}:   # Obviously, crash time cant be bigger than the completion time of the activity
  crashCompletionTime[i] <= completionTime[i];

################################## Desicion vars ###########################

var x {Nodes} >= 0; # Decision variable that represent the start time we assign to each activity
var c {Nodes} >= 0; # Variable indicating the time we crash the activity

################################### Costs ##################################

var Activity_Cost =   # Cost of execution of the activity
  sum{i in Nodes} if (completionTime[i] == crashCompletionTime[i]) then (executionCost[i]) else (executionCost[i] + c[i]*(crashCost[i] - executionCost[i])/(completionTime[i] - crashCompletionTime[i]));

var Project_Directioning_Cost =  # Cost of directioning the project
  sum{f in Final_Activity} x[f]*directioningCost;

var Interest_Cost =   # Cost of insterest in case we need a loan (we pay the interest), else its 0.
  max(0, (Activity_Cost+Project_Directioning_Cost-b0)*r);

var Total_Cost =  # Sum of all three costs
  Activity_Cost + Project_Directioning_Cost + Interest_Cost;

var Total_Time =  # x[f]
  sum {f in Final_Activity} x[f];

################################### Constraints ##################################

subject to Precedence_Relationship {(i,j) in Arcs}: # precedence relationship considering crashed time.
  x[j] >= x[i] + completionTime[i] - c[i];

subject to Crash_Time_Constraint {i in Nodes}:  # Set the upper bound for the crash time of each activity
  c[i] <= (completionTime[i] - crashCompletionTime[i]);

################################### Objective function ##################################

minimize Time_Cost_Objective:   # Now we consider total completion time and cost for the project
  w*Total_Time + (1-w)*Total_Cost;
