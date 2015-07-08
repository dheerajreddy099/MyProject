#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: cron
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#

%w(cronie cronie-anacron crontabs).each do |pkg|
  package pkg do
    action :install
  end
end

service 'crond' do
  action [:enable, :start]
end

template '/var/spool/cron/root' do
  source 'cron/root.erb'
  mode 00600
  owner 'root'
  group 'root'
  action :create_if_missing
end

template '/etc/cron.allow' do
  source 'cron/cron.allow.erb'
  mode 00600
  owner 'root'
  group 'root'
end
