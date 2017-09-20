import sqlalchemy as sa

from docplex.mp.model import Model
from collections import namedtuple
import math

from mssql_config import sa_string, url, api_key


def model_python(conn):
    mdl = Model()
    cur = conn.cursor()

    Food = namedtuple("Food", ["name", "unit_cost", "qmin", "qmax"])
    Nutrient = namedtuple("Nutrient", ["name", "qmin", "qmax"])

    # Reading the 3 tables from the database
    cur.execute('select name,unit_cost,qmin,qmax from diet_food')
    FOODS = cur.fetchall()
    cur.execute('select * from diet_nutrients')
    NUTRIENTS = cur.fetchall()
    cur.execute('select * from diet_food_nutrients')
    FOOD_NUTRIENTS = cur.fetchall()
    cur.close()

    food = [Food(*f) for f in FOODS]
    nutrients = [Nutrient(*row) for row in NUTRIENTS]

    food_nutrients = {(fn[0], nutrients[n].name): fn[1 + n] for fn in FOOD_NUTRIENTS for n in range(len(NUTRIENTS))}
    # Decision variables, limited to be >= Food.qmin and <= Food.qmax
    qty = {f: mdl.continuous_var(lb=f.qmin, ub=f.qmax, name=f.name) for f in food}

    # Limit range of nutrients, and mark them as KPIs
    for n in nutrients:
        amount = mdl.sum(qty[f] * food_nutrients[f.name, n.name] for f in food)
        mdl.add_range(n.qmin, amount, n.qmax)
        mdl.add_kpi(amount, publish_name="Total %s" % n.name)

    # Minimize cost
    cost = mdl.sum(qty[f] * f.unit_cost for f in food)
    mdl.add_kpi(cost, publish_name='cost')
    mdl.minimize(cost)

    mdl.print_information()
    return (mdl, qty)


def pretty_print(tuplelist, columns):
    colsizes = [0] * len(columns)
    for t in tuplelist:
        sizes = [len(str(e)) for e in t]
        for i, s in enumerate(sizes):
            colsizes[i] = max(colsizes[i], s)
    fmt = '  '.join(['%%-%ss' % (int(math.log10(len(tuplelist))) + 1)] +
                    ['%%%ss' % c for c in colsizes])
    print(fmt % tuple([''] + columns))
    for i, v in enumerate(tuplelist):
        print(fmt % ((i,) + v))


def publish_report(mdl, qty, conn):
    all_vars = [(k.name, v.solution_value) for k, v in qty.iteritems()
                if v.solution_value != 0]
    print('Variables:')
    pretty_print(all_vars, ['name', 'quantity'])

    all_kpis = [(v.name, v.solution_value) for v in mdl.iter_kpis()]
    print('KPIs:')
    pretty_print(all_kpis, ['name', 'quantity'])

    cur = conn.cursor()
    cur.executemany("insert into results_var(name, quantity) values(?,?)", all_vars)
    cur.executemany("insert into results_kpi(name, quantity) values(?,?)", all_kpis)
    conn.commit()
    cur.close()


if __name__ == '__main__':
    print('connecting to %s' % sa_string)
    engine = sa.create_engine(sa_string)
    conn = engine.raw_connection()
    mdl, qty = model_python(conn)
    mdl.solve(url=url, key=api_key)
    publish_report(mdl, qty, conn)
