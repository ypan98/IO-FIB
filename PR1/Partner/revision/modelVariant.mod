set Kompanies;
set Periods;

param Bundle_price {Kompanies} >= 0 default 0;
param Bundle_minutes {Periods, Kompanies} >= 0 default 0;
param Period_price {Periods} >= 0 default 0;
param Period_minutes {Periods} >= 0;

var choose_bundle {Kompanies} binary;

var moneyFromCompanies =
		sum{k in Kompanies} ( Bundle_price[k]*choose_bundle[k] );

var moneyFromRetail =
		sum{i in Periods} ((Period_minutes[i] - sum{k in Kompanies} ( Bundle_minutes[i,k]*choose_bundle[k])) * Period_price[i]);

maximize revenue : moneyFromRetail+moneyFromCompanies;

s.t. time_not_negative{i in Periods} :
Period_minutes[i] - sum{k in Kompanies} (Bundle_minutes[i,k]*choose_bundle[k]) >= 0;
