#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: mlocate
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#
package 'mlocate' do
  action :install
end

template '/etc/updatedb.conf' do
  source 'mlocate/updatedb.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
end
