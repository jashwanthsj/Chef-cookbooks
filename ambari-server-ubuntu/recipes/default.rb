######AMBARI-SERVER #########
apt_package 'chkconfig' do
        action :install
end

apt_repository 'ambari' do
   uri node['ambari-server-ubuntu']['uri']
   distribution node['ambari-server-ubuntu']['distribution']
   components ['main']
   keyserver node['ambari-server-ubuntu']['keyserver']
   key node['ambari-server-ubuntu']['key']
end

execute 'update' do
    command 'apt-get update'
end


apt_package 'ntp' do
	action :install
end

execute 'chkconfig' do
	command 'chkconfig ntp on'
end

service 'ntpd' do
	action :start
end

apt_package 'ambari-server' do
	action :install
end

execute 'do setup' do
	command 'ambari-server setup -s'
end

execute 'start ambari-server' do
	command '/usr/sbin/ambari-server start'
end

template '/root/.ssh/id_rsa' do
        source 'key.erb'
        owner 'root'
        group 'root'
        mode '0400'
end

execute "generate ssh key for root." do
    user root
    creates "/root/.ssh/hdp.pub"
    command "ssh-keygen -t rsa -q -f /root/.ssh/hdp.pub -P \"\""
  end
