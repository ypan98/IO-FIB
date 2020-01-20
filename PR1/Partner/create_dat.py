import argparse
from random import SystemRandom


__template = """set Kompanies := {kompanies_set};
set Periods := {periods_set};

param Bundle_price :=
{bundle_price};

param Bundle_minutes: {kompanies_set} :=
{bundle_minutes};

param Period_price := 
{period_prices};

param Period_minutes :=
{period_minutes};
"""

def generate_problem(k: int, i: int):
	"""
		Generates data for the television network model.
		It accepts k for number of companies and i for number of periods.
		Everything is randomly generated.
	"""
	max_bundle_price = 1000000
	max_minute_price = 3
	max_minutes_period = 100*i
	max_minutes_kompany_period = int(max_minutes_period/i)
	random_generator = SystemRandom()
	
	kompanies_list = [f'K{x}' for x in range(0,k)]
	periods_list = [f'P{x}' for x in range(0,i)]

	kompanies_set = ' '.join(kompanies_list)
	periods_set = ' '.join(periods_list)

	bundle_price = ''.join( [f'{x} {random_generator.randrange(1,max_bundle_price)}\n' for x in kompanies_list] )
	period_prices = ''.join( [f'{x} {random_generator.random()*max_minute_price}\n' for x in periods_list] )

	ls_period_minutes = [random_generator.randrange(1, max_minutes_period) for _ in periods_list]
	period_minutes = ''.join( [f'{x} {y}\n' for x,y in zip(periods_list, ls_period_minutes)] )

	bundle_minutes = ''.join([f'{p} {" ".join([str(random_generator.randrange(0,max_minutes_kompany_period)) for x in kompanies_list])}\n' for p in periods_list])
	
	problem = __template.format(kompanies_set=kompanies_set,
								  periods_set=periods_set,
								  bundle_price=bundle_price,
								  bundle_minutes=bundle_minutes,
								  period_prices=period_prices,
								  period_minutes=period_minutes)
	print(problem)


if __name__ == '__main__':
	parser = argparse.ArgumentParser(description='Generate problem for television network')
	parser.add_argument('k', type=int, help='Number of companies')
	parser.add_argument('i', type=int, help='Number of periods')

	args = parser.parse_args()	
	generate_problem(args.k, args.i)
