default['cassandra']['source_url']     = 'http://debian.datastax.com/community'
default['cassandra']['component']      =  %w(stable main)
default['cassandra']['key']            = 'http://debian.datastax.com/debian/repo_key'
default['cassandra']['apt']['action']  = :add

default['cassandra']['cassandra_version']  = '2.1.8'

default['cassandra']['cluster_name'] = 'Prod_Cluster'
default['cassandra']['authenticator'] = 'PasswordAuthenticator'
default['cassandra']['authorizer'] = 'CassandraAuthorizer'
default['cassandra']['data_file_directories'] = '[]'
default['cassandra']['seeds'] = '[]'
default['cassandra']['listen_address'] = '[]'
default['cassandra']['rpc_address'] = '[]'
default['cassandra']['endpoint_snitch'] = 'Ec2Snitch'

