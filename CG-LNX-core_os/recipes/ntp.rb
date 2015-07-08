#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: ntp
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#

package 'ntp' do
  action :install
end

template '/etc/ntp.conf' do
  source 'ntp/ntp.conf.erb'
  mode 00644
  owner 'root'
  group 'sys'
  notifies :restart, 'service[ntpd]'
end

template node['CG-LNX-core_os']['ntp']['keys'] do
  source 'ntp/keys.erb'
  mode 00400
  owner 'ntp'
  group 'ntp'
end

service 'ntpd' do
  action [:enable, :start]
end

