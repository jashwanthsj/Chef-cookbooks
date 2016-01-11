#include_recipe 'ambari-agent::pub_add'

template '/root/.ssh/id_rsa' do
	source 'key.erb'
	owner 'root'
	group 'root'
	mode '0400'
end
