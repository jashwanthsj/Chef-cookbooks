execute 'remove restriction to login as root user from ambari server' do
    command "sed -i -r 's/.{155}//' /root/.ssh/authorized_keys"
end

file '/root/.ssh/temp.pub' do
  content "#{node['ambari-agent']['ambari-server-key']}"
  mode '0755'
  owner 'root'
  group 'root'
end

include_recipe 'ambari-agent::pub_add'
