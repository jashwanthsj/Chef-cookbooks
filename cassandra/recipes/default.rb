
##For Java
include_recipe 'java::default'

##Cassandra Installation
apt_repository 'cassandra' do
 uri node['cassandra']['source_url']
 components node['cassandra']['component']
 key node['cassandra']['key']
 action :add
end

package 'cassandra' do
version node['cassandra']['cassandra_version']
action :install 
end

##Config change
template '/etc/cassandra/cassandra.yaml' do
  source 'cassandra.yaml.erb'
  owner 'root'
  group 'root'
  mode '0777'
end 

##Stop cassandra if it is running
execute 'cassandra' do
  command 'sudo service cassandra stop'
end

