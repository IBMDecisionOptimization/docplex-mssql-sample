
# IBM Decision Optimization Modeling for Python (DOcplex) Microsoft SQL Server sample

This repository contains:

   * `mssql_tuples.py`: a sample that shows how to read Python `tuple`s
   from a Microsoft SQL Server data source, then use the data to build and
   solve an optimization model with DOcplex. Then the results and KPIs are
   saved to the database.

   * `mssql_pandas.py`: a sample that shows how to read
   `Pandas.DataFrame`s from a Microsoft SQL Server data source, then use
   the data to build and solve an optimization model with DOcplex. Then the
   result and KPIs are published in tables in the database.

The optimization problem can be solved on
[IBM Decision Optimization on Cloud](https://developer.ibm.com/docloud/) (requires
an API Key, for which a [free trial](#docloud) is available) or on premise using
IBM ILOG CPLEX Optimization Studio (a free [Community Edition](#cplex_ce) is available)

While these samples use Microsoft SQL Server as data source, it can be easily
adapted to any database that provide an ODBC driver.


## Install software

The sample assumes that IBM Decision Optimization Modeling for Python (DOcplex)
is installed. To install DOcplex, type this command in a command prompt:

```
pip install docplex
```

For alternate ways of installing DOcplex, for example using `conda`, refer to the
[DOcplex installation guide](http://ibmdecisionoptimization.github.io/docplex-doc/getting_started_python.html).

You also need third party modules used to connect to the database. These samples
use [pyodbc](https://github.com/mkleehammer/pyodbc) to connect to the ODBC
data source. To install pyodbc, type this command in a command prompt:
```
pip install pyodbc
```

The sample also use [SQLAlchemy](https://www.sqlalchemy.org/).
To install SQLAlchemy, type this in a command prompt:

```
pip install SQLAlchemy
```

The sample has been written for MS SQL Server. If you don't already have a
server up and running, download and install
[Microsoft SQL Server 2014 Express](https://www.microsoft.com/download/details.aspx?id=42299).

### <a id="docloud"></a>Get your IBM Decision Optimization on Cloud API key

You can run your optimization in the cloud with the IBM
Decision Optimization on Cloud service.
   
- Register for the DOcplexcloud free trial and use it free for 30 days. See [Try DOcplexcloud for free](https://developer.ibm.com/docloud/try-docloud-free).
 
- Get your API key
    With your free trial, you can generate a key to access the DOcplexcloud API. 
    Visit the [Get API key & base URL](http://developer.ibm.com/docloud/docs/api-key) page to generate the key once you've registered. 
    This page also contains the base URL you must use for DOcplexcloud.
    
- Copy/paste your API key and service URL in `mssql_config.py`, or have a
    look at [Setting up an optimization engine](http://ibmdecisionoptimization.github.io/docplex-doc/getting_started.html) 
    section of the documentation.


### Get your IBM ILOG CPLEX Optimization Studio edition

To run your optimization on your machine, you will need ILOG IBM CPLEX.

- <a id="cplex_ce"></a>You can get a free [Community Edition](http://www-01.ibm.com/software/websphere/products/optimization/cplex-studio-community-edition)
 of CPLEX Optimization Studio, with limited solving capabilities in term of problem size.

- Faculty members, research professionals at accredited institutions can get access to an unlimited version of CPLEX through the
 [IBM Academic Initiative](https://developer.ibm.com/academic/).



## Run the sample with <b>Microsoft SQL Server</b>

### Create the sample database

The `diet_mssql.sql` file in the sample directory contains the SQL script
to create the sample database and tables.

In a command prompt window, type:

```
sqlcmd -S yourServer\instanceName -i diet_mssql.sql
```

Replace `yourServer\instanceName` with the appropriate information
for your server. If you installed Microsoft SQL Server 2014 Express, the default
value for this string should be `.\SQLEXPRESS`

### Run the python sample

Edit `mssql_config.py` for your database connection string.

Run the sample that read tables from the database, create `pandas.DataFrame`
and use the data frames as input to a DOcplex model:

```
python mssql_pandas.py
```

Run the sample that read tables from the database, create Python tuples and use
the tuples as input to a DOcplex model:

```
python mssql_tuples.py
```

## License

This sample is delivered under the Apache License Version 2.0, January 2004 (see LICENSE.txt).
