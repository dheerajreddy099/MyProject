#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: nbu
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#

link '/usr/openv' do
  to '/users/openv'
end

directory node['CG-LNX-core_os']['nbu']['home'] do
  owner 'root'
  group 'bin'
  action :create
end

template '/usr/openv/netbackup/bp.conf' do
  source 'nbu/bp.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
end

template '/usr/openv/netbackup/exclude_list' do
  source 'nbu/exclude_list.erb'
  mode 00644
  owner 'root'
  group 'bin'
  :create_if_missing
end

remote_file '/nbu.tar' do
  source "http://#{node['pkgdist_server']}/pkgdist/linux/nbu/nbu.tar"
  notifies :run, 'bash[Extract NBU]', :immediately
  not_if '/sbin/chkconfig --list netbackup > /dev/null 2>&1'
end

bash 'Extract NBU' do
  user 'root'
  cwd '/'
  code <<-EOH
     tar xvf nbu.tar
     rm nbu.tar
  EOH
  notifies :run, 'bash[Install NBU]', :immediately
  only_if { ::File.exist?('/nbu.tar') }
  action :nothing
end

bash 'Install NBU' do
  user 'root'
  cwd '/NBU76'
  code <<-EOH
./install << ANSWERS
y
y
ANSWERS
  rm -rf /NBU76
  EOH
  only_if { ::File.exist?('/NBU76/install') }
  action :nothing
end

