#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: etc
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#

template '/etc/auto.master' do
  source 'etc/auto.master.erb'
  mode 00644
  owner 'root'
  group 'root'
end

template '/etc/auto.direct' do
  source 'etc/auto.direct.erb'
  mode 00644
  owner 'root'
  group 'root'
  action :create_if_missing
end

template '/etc/aliases' do
  source 'etc/aliases.erb'
  mode 00644
  owner 'root'
  group 'root'
  notifies :run, 'bash[New Aliases]', :immediately
end

bash 'New Aliases' do
  user 'root'
  code <<-EOH
    /usr/bin/newaliases
  EOH
  action :nothing
end

template '/etc/motd' do
  source 'etc/motd.erb'
  mode 00644
  owner 'root'
  group 'root'
end

template '/usr/local/etc/motd' do
  source 'etc/usr_local_motd.erb'
  mode 00755
  owner 'root'
  group 'root'
end

template '/etc/profile' do
  source 'etc/profile.erb'
  mode 00644
  owner 'root'
  group 'root'
end

template '/etc/inittab' do
  source 'etc/inittab.erb'
  mode 00644
  owner 'root'
  group 'root'
end

template '/etc/securetty' do
  source 'etc/securetty.erb'
  mode 00600
  owner 'root'
  group 'root'
end

template '/etc/shells' do
  source 'etc/shells.erb'
  mode 00644
  owner 'root'
  group 'root'
end

template '/etc/csh.login' do
  source 'etc/csh.login.erb'
  mode 00644
  owner 'root'
  group 'root'
end

template '/etc/sysconfig/prelink' do
  source 'etc/prelink.erb'
  mode 00644
  owner 'root'
  group 'root'
  variables(
    prelink: node['CG-LNX-core_os']['etc']['prelink']
  )
end

directory '/etc/sysctl.d' do
  action :create
  owner 'root'
  group 'root'
end

template '/etc/sysctl.d/10-kernel.sysrq' do
  source '/etc/10-kernel.sysrq.erb'
  mode 00644
  owner 'root'
  group 'root'
end
