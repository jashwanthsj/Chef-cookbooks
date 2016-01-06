######AMBARI-SERVER #########
execute 'update' do
    command 'yum update -y'
end

yum_repository = node['ambari']['cent_repo']

remote_file '/etc/yum.repos.d/ambari.repo' do
	source yum_repository
	not_if { ::File.exist?('/etc/yum.repos.d/ambari.repo') }
end

yum_package 'ntp' do
	action :install
end

execute 'chkconfig' do
	command 'chkconfig ntpd on'
end

service 'ntpd' do
	action :start
end

yum_package 'selinux-policy-targeted' do
	action :install
end

template '/etc/selinux/config' do
	source 'selinux.config.erb'
	owner 'root'
	group 'root'
end

execute 'chkconfig' do
	command 'chkconfig iptables off'
end

service 'iptables' do
	action :stop
end

yum_package 'ambari-server' do
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