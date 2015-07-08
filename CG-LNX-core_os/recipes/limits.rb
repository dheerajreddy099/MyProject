#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: limits
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#

template '/etc/security/limits.conf' do
  source 'limits/limits.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
end

template '/etc/security/limits.d/90-nproc.conf' do
  source 'limits/limits.d/90-nproc.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
end
