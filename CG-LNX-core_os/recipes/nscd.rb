#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: nscd
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#
package 'nscd' do
  action :install
end

template '/etc/nscd.conf' do
  source 'nscd/nscd.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
  notifies :reload, 'service[nscd]', :delayed
end

service 'nscd' do
  action [:enable, :start]
end

