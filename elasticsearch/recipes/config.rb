
# Configure the logstash file

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  owner 'root'
  group 'root'
  mode '0777'                             # Other permission won't work on AWS environment.
#  notifies :restart, "service[elasticsearch]"
end