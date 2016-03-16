######AMBARI-SERVER #########
apt_package 'chkconfig' do
        action :install
end

apt_repository 'ambari' do
   uri node['ambari-server-mysql-new']['uri']
   distribution node['ambari-server-mysql-new']['distribution']
   components ['main']
   keyserver node['ambari-server-mysql-new']['keyserver']
   key node['ambari-server-mysql-new']['key']
end

execute 'update' do
    command 'apt-get update'
end

apt_package 'unzip' do
         action :install
end

#apt_package 'libmysql-java' do
#        action :install
#end

script "install latest mysql driver" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    wget http://dev.mysql.com/get/Downloads/Connector-J/#{node['ambari-server-mysql-new']['driver']}.zip
    unzip #{node['ambari-server-mysql-new']['driver']}.zip
    mv #{node['ambari-server-mysql-new']['driver']}/#{node['ambari-server-mysql-new']['driver']}-bin.jar /usr/share/java
  EOH
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

apt_package 'ambari-server' do
	action :install
end

execute 'setup ambari-server' do
    command "ambari-server setup -s --database=mysql --databasehost=#{node['ambari-server-mysql-new']['dbhostname']} --databaseport=3306 --databasename=#{node['ambari-server-mysql-new']['dbname']} --databaseusername=#{node['ambari-server-mysql-new']['dbusername']} --databasepassword=#{node['ambari-server-mysql-new']['dbpasswd']}"
end

execute 'Initialize JDBC driver' do
    command "ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/#{node['ambari-server-mysql-new']['driver']}-bin.jar"
end

template '/tmp/grant.sql' do
  source 'grant.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

execute 'Grant permissions for ambari user to connect db' do
        command "mysql -h #{node['ambari-server-mysql-new']['dbhostname']} -P 3306 -u #{node['ambari-server-mysql-new']['dbusername']} -p'#{node['ambari-server-mysql-new']['dbpasswd']}' <  /tmp/grant.sql"
end

#execute 'create tables for ambari' do
#        command "mysql -h #{node['ambari-server-mysql-new']['dbhostname']} -P 3306 -u #{node['ambari-server-mysql-new']['dbusername']} -p'#{node['ambari-server-mysql-new']['dbpasswd']}' #{node['ambari-server-mysql-new']['dbname']} <  /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql"
#end
bash 'create-tables' do
        user 'root'
        cwd '/home/'
        code <<-EOH
        if ! mysql -h #{node['ambari-server-mysql-new']['dbhostname']} -P 3306 -u #{node['ambari-server-mysql-new']['dbusername']} -p'#{node['ambari-server-mysql-new']['dbpasswd']}' #{node['ambari-server-mysql-new']['dbname']} ; then
             mysql -h #{node['ambari-server-mysql-new']['dbhostname']} -P 3306 -u #{node['ambari-server-mysql-new']['dbusername']} -p'#{node['ambari-server-mysql-new']['dbpasswd']}' -e "CREATE DATABASE IF NOT EXISTS #{node['ambari-server-mysql-new']['dbname']}";
             mysql -h #{node['ambari-server-mysql-new']['dbhostname']} -P 3306 -u #{node['ambari-server-mysql-new']['dbusername']} -p'#{node['ambari-server-mysql-new']['dbpasswd']}' #{node['ambari-server-mysql-new']['dbname']} <  /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql
        fi
        EOH
end

execute 'start ambari-server' do
	command '/usr/sbin/ambari-server start'
end

execute 'generate ssh key for root.' do
    command 'ssh-keygen -t rsa -q -f /root/.ssh/id_rsa -q -N ""'
    not_if { ::File.exist?('/root/.ssh/id_rsa') }
end

file '/root/.ssh/id_rsa' do
        mode '0400'
end

