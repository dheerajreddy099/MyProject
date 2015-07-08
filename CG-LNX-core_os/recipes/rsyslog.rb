#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: rsyslog
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#
package 'rsyslog' do
  action :install
end

template '/etc/rsyslog.conf' do
  source 'rsyslog/rsyslog.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
  notifies :restart, 'service[rsyslog]'
end

service 'rsyslog' do
  action [:enable, :start]
end
