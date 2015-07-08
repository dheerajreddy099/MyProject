#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: resolv
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#
template '/etc/resolv.conf' do
  source 'resolv/resolv.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
end

