set AUDIENCIA;
set MEDIO_PUBLI;
set AUD_MED within (AUDIENCIA cross MEDIO_PUBLI);

param exposicion {AUDIENCIA} >= 0;	#nivel de exposicion para cada audiencia
param efectividad {AUD_MED} >= 0;	#efectividad de invertir un dolar en un medio
									#  de publicidad sobre una audiencia

var inversion {AUD_MED} >= 0;

minimize Coste_Total:  #intentamos minimizar el gasto total
	sum {(i,j) in AUD_MED} inversion[i,j];

subject to Nivel_Expo {i in AUDIENCIA}:
	sum {j in MEDIO_PUBLI} inversion[i, j]*efectividad[i,j] >= exposicion[i];
# La unica restriccion que tenemos es cumplir los niveles de exposicion
# que pide el cliente para cada tipo de audiencia
