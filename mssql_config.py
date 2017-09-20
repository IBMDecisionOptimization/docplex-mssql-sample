'''
Configuration file for MS SQL Server data source
@author: kong
'''

#
# The following parameters are used to configure the connection to
# Microsoft SQL Server
#
server = '.\SQLEXPRESS'
database = 'diet_sample_db'
driver = 'SQL+Server+Native+Client+11.0'
sa_string = 'mssql+pyodbc://{server}/{database}?driver={driver}'.format(server=server, database=database, driver=driver)

#
# The following parameters are used to connect to DOCplexcloud. Leave the
# values to None if you want docplex to use the locally installed CPLEX.
#
url = None
api_key = None