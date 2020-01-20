set Kompanies;
set Periods;

param Bundle_price {Kompanies} >= 0 default 0;
param Bundle_minutes {Periods, Kompanies} >= 0 default 0;
param Period_price {Periods} >= 0 default 0;
param Period_minutes {Periods} >= 0;

var choose_bundle {Kompanies} binary;
var minutes_period {i in Periods} =
	Period_minutes[i] - sum{k in Kompanies} ( Bundle_minutes[i,k]*choose_bundle[k] ); 

maximize revenue : sum{k in Kompanies} ( Bundle_price[k] * choose_bundle[k] ) + 
				   sum{i in Periods}    ( minutes_period[i] * Period_price[i] );

s.t. minutes_per_period{i in Periods} : 
	minutes_period[i] >= 0;
