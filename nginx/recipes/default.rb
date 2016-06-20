execute "apt-get update" do
  command "apt-get update"
end

package 'nginx' do
  action :install
end

directory '/usr/share/nginx/html/' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file "/usr/share/nginx/html/index.html" do
  source "index.html"
  mode "0644"
end

service 'nginx' do
  action [ :enable, :start ]
end

ruby_block 'check the response of nginx' do
  block do
    require 'net/http'
    response = nil
    Net::HTTP.start('localhost', 80) {|http|
    response = http.head('/index.html')
    }
    puts "the response code from the nginx is #{response.code}"
end
end

line = 'vagrant ALL=(ALL) NOPASSWD:ALL'

file = Chef::Util::FileEdit.new('/etc/sudoers')
file.insert_line_if_no_match(/#{line}/, line)
file.write_file

template '/etc/nginx/nginx.conf' do
  notifies :restart, 'service[nginx]'
end

directory '/etc/nginx/conf.d/' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/nginx/conf.d/load-balancer.conf' do
  source 'load-balancer.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

file '/etc/nginx/sites-enabled/default' do
  action :delete
end

service 'nginx' do
  action :restart
end
