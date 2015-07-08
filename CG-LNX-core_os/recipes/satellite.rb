# If not already registered with correct Satellite, bootstrap
yumrepolist = `yum repolist -v`
unless yumrepolist.match "#{node['CG-LNX-core_os']['satellite']['server']}"
  remote_file '/tmp/bootstrap.sh' do
    source "http://#{node['CG-LNX-core_os']['satellite']['server']}/pub/bootstrap/bootstrap.sh"
    mode '0700'
    # not_if { File.exist?('/tmp/bootstrap.sh') }
  end

  execute 'bootstrap' do
    command '/tmp/bootstrap.sh'
  end

  file '/tmp/bootstrap.sh' do
    action :delete
  end
end

service 'osad' do
  action [:enable, :start]
end

# See if there are any patches to apply, and do it.
# In a ruby block so 'yum check-update' will be evaluated
# after client is registered in Satellite, not in compile stage.
ruby_block 'yum update check' do
  block do
    system('yum update -y')
  end
  not_if 'yum check-update'
end
# reboot resource appears in Chef 12
#    reboot "Post-Patch Reboot" do
#    action :request_reboot
#    delay_mins 1
#    end

