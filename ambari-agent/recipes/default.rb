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
#include_recipe 'ambari-agent::blocks'

#=begin
if "#{node[:opsworks][:instance][:instance_type]}" =~ /d2\./
  bash 'auto format and mount blocks' do
       user 'root'
       code <<-EOH
       count=1
       for f in `lsblk  -d -n -oNAME`; do
         echo "Found block: $f"
         if mount | grep -q "/dev/$f"; then
            echo "mounted $f"
         else
            [ -d "/data$count" ] || mkdir "/data$count"
            if file -sL /dev/$f | grep -q 'xfs filesystem data'; then
               echo "$f is formated"
            else
               mkfs -t xfs /dev/$f
            fi
            mount /dev/$f "/data$count"
            count=$((count+1))
            fi
          done
        EOH
  end
end
#=end
