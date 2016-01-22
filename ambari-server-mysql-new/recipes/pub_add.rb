ruby_block "add_pub_key" do
  block do
    to_append = File.read("/root/.ssh/hdp-cluster.pub")
    File.open("/root/.ssh/authorized_keys", "a") do |handle|
    handle.puts to_append
end
end
end
