#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: nfs-utils
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#

package 'nfs-utils' do
  action :install
end

template '/etc/nfsmount.conf' do
  source 'nfs-utils/nfsmount.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
end

template '/etc/sysconfig/nfs' do
  source 'nfs-utils/nfs.erb'
  mode 00644
  owner 'root'
  group 'root'
end
