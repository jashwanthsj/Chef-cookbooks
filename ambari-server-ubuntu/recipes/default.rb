######AMBARI-SERVER #########
execute 'update' do
    command 'apt-get update'
end

apt_package 'chkconfig' do
        action :install
end


#yum_repository = node['ambari']['repo']

apt_repository 'Ambari' do
    uri node['ambari-server-ubuntu']['repo']
    distribution 'Ambari'
    components ['main']
    keyserver    'hkp://keyserver.ubuntu.com:80'
    key          'B9733A7A07513CAD'
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

#yum_package 'selinux-policy-targeted' do
#	action :install
#end

#template '/etc/selinux/config' do
#	source 'selinux.config.erb'
#	owner 'root'
#	group 'root'
#end

execute 'chkconfig' do
	command 'chkconfig iptables off'
end

service 'iptables' do
	action :stop
end

apt_package 'ambari-server' do
	action :install
end

execute 'do setup' do
	command 'ambari-server setup -s'
end

#service 'ambari-server' do
	#supports :start => true, :stop => true, :restart => true, :status => true, :setup => true
	#action [:enable, :start]
#end

execute 'start ambari-server' do
	command '/usr/sbin/ambari-server start'
end

#include_recipe 'ambari::pub_add'

template '/root/.ssh/id_rsa' do
        source 'key.erb'
        owner 'root'
        group 'root'
end
