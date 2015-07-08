#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: setup
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#

user 'ftp' do
  action :remove
  only_if 'grep ^ftp: /etc/passwd'  # only remove locally
end

group 'ftp' do
  action :remove
  only_if 'grep ^ftp: /etc/group'  # only remove locally
end

user 'games' do
  action :remove
  only_if 'grep ^games: /etc/passwd'  # only remove locally
end

# group 'users' do
# gid node['CG-LNX-core_os']['setup']['users']['default']['gid']
# action :modify
# end

# Centrify will create its own users group, we don't want a local one.
group 'users' do
  action :remove
  only_if 'grep ^users: /etc/group'  # only remove locally
end

ruby_block 'Rename bashrc' do
  block do
    File.rename('/root/.bashrc', '/root/.bashrc.orig')
  end
  not_if { File.exist?('/root/.bashrc.orig') }
end

ruby_block 'Rename bash_profile' do
  block do
    File.rename('/root/.bash_profile', '/root/.bash_profile.orig')
  end
  not_if { File.exist?('/root/.bash_profile.orig') }
end

template '/etc/modprobe.d/ipv6.conf' do
  source 'setup/ipv6.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
end

template '/root/.kshrc' do
  source 'setup/root_kshrc.erb'
  mode 0600
  owner 'root'
  group 'root'
end

template '/root/.profile' do
  source 'setup/root_profile.erb'
  mode 0400
  owner 'root'
  group 'root'
end

node['CG-LNX-core_os']['setup']['remove']['packages'].each do |rm_packagename|
  package rm_packagename do
    action :remove
  end
end

node['CG-LNX-core_os']['setup']['add']['packages'].each do |add_packagename|
  package add_packagename do
    action :install
  end
end

node['CG-LNX-core_os']['setup']['add']['packages_i686'].each do |add_packagename_i686|
  yum_package add_packagename_i686 do
    action :install
    arch 'i686'
  end
end

node['CG-LNX-core_os']['setup']['directory']['remove'].each do |rm_dirname|
  directory rm_dirname do
    action :delete
  end
end

node['CG-LNX-core_os']['setup']['symlink'].each do |lnkname, linkref|
  link lnkname do
    to linkref
  end
end

template '/etc/default/useradd' do
  source 'setup/useradd.erb'
  mode 00600
  owner 'root'
  group 'root'
end

directory '/storage' do
  owner 'root'
  group 'root'
  mode 00700
  action :create
end

template '/storage/sroot' do
  source 'setup/sroot.erb'
  mode 00700
  owner 'root'
  group 'root'
end

execute 'disk_scheduler' do
  command 'grubby --update-kernel=ALL --args=\"elevator=noop\"'
  not_if 'grubby --info=ALL | grep elevator=noop'
end

execute 'noisy_startup' do
  command 'grubby --update-kernel=ALL --remove-args=\"quiet rhgb\"'
  only_if 'grubby --info=ALL | grep -E \"quiet|rhgb\"'
end