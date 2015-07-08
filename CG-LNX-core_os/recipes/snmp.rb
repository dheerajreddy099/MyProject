#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: snmp
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#

package 'net-snmp' do
  action :install
end

package 'net-snmp-utils' do
  action :install
end

template '/etc/snmp/snmpd.conf' do
  source 'snmp/snmpd.conf.erb'
  mode 00600
  owner 'root'
  group 'root'
  notifies :restart, 'service[snmpd]'
end

service 'snmpd' do
  action [:enable, :start]
end

