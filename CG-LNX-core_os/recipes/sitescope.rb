# create home directory and .ssh
%w( /home/sismon /home/sismon/.ssh ).each do |path|
  directory path do
    mode '0755'
    notifies :run, 'ruby_block[chownfiles]', :delayed
  end
end

template '/home/sismon/.ssh/authorized_keys' do
  source 'sitescope/authorized_keys.erb'
  mode 0600
end

# Run in a ruby block because the sismon user doesn't exist on the first chef
# run.
ruby_block 'chownfiles' do
  block do
    system('chown -R sismon:users /home/sismon') if system('id sismon')
  end
  action :nothing
end
