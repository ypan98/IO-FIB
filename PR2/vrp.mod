set NODES;  # All nodes
set ARCS within (NODES cross NODES);	# Arcs in the graph
set A_ARCS within (NODES cross NODES);	# Affected Arcs
set DEPOT within (NODES);
set CLIENTS within (NODES);
set CD = CLIENTS union DEPOT;
set CD_ARCS = {i in CD, j in CD: i != j};	# All arcs (client_depot, client_depot)

param I {NODES} default 0;  # i,j For calculation of cost
param J {NODES} default 0;
param dist{NODES cross NODES} default 1000000;  # dist = cost


############# VRP ##############
param k = 3;
param client_demand = 10;
param C = 40;

var x {CD_ARCS} binary;
var u {CD} >= 0;

####### MTZ #######

subject to LowerBound {i in CLIENTS}:
  client_demand <= u[i];

subject to UpperBound {i in CLIENTS}:
  u[i] <= C;

subject to Subcircuit {i in CLIENTS, j in CLIENTS: i != j}:
  u[j] >= u[i] + client_demand - C*(1-x[i,j]);

##################

# One incoming edge for each client
subject to Client_In {j in CLIENTS}:
  sum {(i,j) in CD_ARCS} x[i,j] = 1;

# One outgoing edge for each client
subject to Client_Out {i in CLIENTS}:
  sum {(i,j) in CD_ARCS} x[i,j] = 1;

# K incoming edge for DEPOT
subject to Depot_In {j in DEPOT}:
  sum {(i,j) in CD_ARCS} x[i,j] = k;

# K outgoing edge for each client
subject to Depot_Out {i in DEPOT}:
  sum {(i,j) in CD_ARCS} x[i,j] = k;

minimize Total_cost:
  sum {(i,j) in CD_ARCS} x[i,j]*dist[i,j];
