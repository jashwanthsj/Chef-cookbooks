template '/etc/cassandra/cassandra.yaml' do
  source 'cassandra.yaml.erb'
  owner 'root'
  group 'root'
  mode '0777'
