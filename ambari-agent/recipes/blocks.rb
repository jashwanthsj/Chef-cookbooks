file '/tmp/blocks.txt' do
  action :create
end

temp="/tmp/temp.txt"
blocks="/tmp/blocks.txt"

bash 'mountblocks' do
        user 'root'
        cwd '/root/'
        code <<-EOH
        lsblk -d -n -oNAME,RO | grep '0$' | awk {'print $1'} > "#{temp}"
        tail -n +2 "#{temp}" > "#{blocks}"
        EOH
end

i=0

node.default[:blocks_array] = []
ruby_block "blockslistarray" do
  block do
  f = open("#{blocks}")
  contents_array = []
  f.each_line { |line| contents_array << line }
  f.close
  node.set[:blocks_array] = "#{contents_array}"
  end
end

blocks_array=node[:blocks_array]

for block in blocks_array
execute 'mkfs' do
  command "mkfs -t xfs /dev/#{block}"
  not_if "grep -qs /dev/#{block} /proc/mounts"
  not_if "blkid -o value -s TYPE /dev/#{block}"
end

i+=1
directory "/data#{i}" do
  mode '0755'
  action :create
end

mount "/data#{i}" do
  device "/dev#{block}"
  fstype 'xfs'
  options 'noatime,nobootwait'
  action [:enable, :mount]
end
end
