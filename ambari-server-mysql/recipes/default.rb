######AMBARI-SERVER #########
apt_package 'chkconfig' do
        action :install
end

apt_package 'libmysql-java' do
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

apt_package 'mysql-client-core-5.5' do
    action :install
end

apt_package 'expect' do
        action :install
end

apt_package 'ambari-server' do
	action :install
end

bash 'Ambari Setup' do
        user 'root'
        code <<-EOF
        /usr/bin/expect -c 'ambari-server setup
        expect "Ambari-server daemon is configured to run under user 'root'. Change this setting [y/n] (n)?"
        send "n\r"
        expect "Do you want to change Oracle JDK [y/n] (n)?"
        send "n\r"
        expect "Enter advanced database configuration [y/n] (n)?"
        send "y\r"
        expect "Enter choice (1):"
        send "3\r"
	expect "Hostname (localhost):"
	send "#{node['ambari-server-ubuntu']['dbhostname']}\r"
	expect "Port (3306):"
	send "3306\r"
	expect "Database name (ambari):"
	send "#{node['ambari-server-ubuntu']['dbname']}\r"
	expect "Username (ambari):"
        send "ambari\r"
	expect "Enter Database Password (bigdata):"
        send "bigdata\r"
	expect "Re-enter password:"
        send "bigdata\r"
        expect "Proceed with configuring remote database connection properties [y/n] (y)?"
        send "y\r"
        expect eof'
        EOF
    end

execute 'create schema for ambari' do
	command "mysql -h node['ambari-server-ubuntu']['dbhostname'] -P 3306 -u node['ambari-server-ubuntu']['dbusername'] -p'#{node['ambari-server-ubuntu']['dbpasswd']}' node['ambari-server-ubuntu']['dbname'] <  /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql"
end

execute 'start ambari-server' do
	command '/usr/sbin/ambari-server stop'
end

template '/root/.ssh/id_rsa' do
        source 'key.erb'
        owner 'root'
        group 'root'
        mode '0400'
end

execute 'generate ssh key for root.' do
    command 'ssh-keygen -t rsa -q -f /root/.ssh/hdp -q -N ""'
    not_if { ::File.exist?('/root/.ssh/hdp') }
end
