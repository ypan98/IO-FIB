set Activities; # Real activities
set Final_Activity;  # Dummy activity to mark the end of the project
set Nodes = Activities union Final_Activity;  # Nodes we are going to use in the LP formulation
set Arcs within (Nodes cross Nodes);  # Arcs that mark precedence relationship between activities

param Completion_Time {Nodes} default 0;  # Completion time associated to each activity

var x {Nodes} >= 0; # Decision variable that represent the start time we assign to each activity

subject to Precedence_Relationship {(i,j) in Arcs}: # (i->j) => activity j start after activity i + its completion time.
  x[j] >= x[i] + Completion_Time[i];

minimize Final_Activity_Time:
  sum{i in Final_Activity} x[i];
