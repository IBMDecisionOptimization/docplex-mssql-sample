import sqlalchemy as sa

import pandas as pd
from docplex.mp.model import Model

from mssql_config import sa_string, url, api_key


def model_python(conn):
    # Read from database
    #
    # Alternatively, we can read table with specific queries like in:
    # nutrients = pd.read_sql_query("select name,qmin,qmax from diet_nutrients;", conn)
    food = pd.read_sql_table('diet_food', conn)
    nutrients = pd.read_sql_table('diet_nutrients', conn)
    food_nutrients = pd.read_sql_table('diet_food_nutrients', conn)

    food_nutrients.set_index('name', inplace=True)

    # Model
    mdl = Model(name='diet')

    # Create decision variables, limited to be >= Food.qmin and <= Food.qmax
    qty = food[['name', 'qmin', 'qmax']].copy()
    qty['var'] = qty.apply(lambda x: mdl.continuous_var(lb=x['qmin'],
                                                        ub=x['qmax'],
                                                        name=x['name']),
                           axis=1)
    # make the name the index
    qty.set_index('name', inplace=True)

    # Limit range of nutrients, and mark them as KPIs
    for n in nutrients.itertuples():
        amount = mdl.sum(qty.loc[f.name]['var'] * food_nutrients.loc[f.name][n.name]
                         for f in food.itertuples())
        mdl.add_range(n.qmin, amount, n.qmax)
        mdl.add_kpi(amount, publish_name='Total %s' % n.name)

    # Minimize cost
    cost = mdl.sum(qty.loc[f.name]['var'] * f.unit_cost
                   for f in food.itertuples())
    mdl.add_kpi(cost, publish_name='cost')
    mdl.minimize(cost)

    mdl.print_information()
    return (mdl, qty)


def publish_report(mdl, qty, conn):
    all_vars = pd.DataFrame([(v.name, v.solution_value) for v in qty['var'].tolist() if v.solution_value != 0],
                            columns=['name', 'quantity'])
    print('Variables:\n%s' % all_vars)

    all_kpis = pd.DataFrame([(v.name, v.solution_value) for v in mdl.iter_kpis()], columns=['name', 'quantity'])
    print('KPIs:\n%s' % all_kpis)

    # Write to Database.
    all_vars.to_sql('results_var', conn, if_exists='replace', index=False)
    all_kpis.to_sql('results_kpi', conn, if_exists='replace', index=False)


if __name__ == '__main__':
    print('connecting to %s' % sa_string)
    engine = sa.create_engine(sa_string)
    mdl, qty = model_python(engine)
    mdl.solve(url=url, key=api_key)
    publish_report(mdl, qty, engine)
