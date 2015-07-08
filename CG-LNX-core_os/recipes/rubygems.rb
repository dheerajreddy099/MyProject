#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: rubygems
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#

remote_file "#{Chef::Config['file_cache_path']}/open4-1.3.4.gem" do
  source "http://#{node['pkgdist_server']}/pkgdist/all/rubygems/open4/1.3.4/open4-1.3.4.gem"
  checksum 'a1df0373'
end
remote_file "#{Chef::Config['file_cache_path']}/di-ruby-lvm-attrib-0.0.16.gem" do
  source "http://#{node['pkgdist_server']}/pkgdist/all/rubygems/di-ruby-lvm-attrib/0.0.16/di-ruby-lvm-attrib-0.0.16.gem"
  checksum '7c4fb44a'
end
remote_file "#{Chef::Config['file_cache_path']}/di-ruby-lvm-0.1.3.gem" do
  source "http://#{node['pkgdist_server']}/pkgdist/all/rubygems/di-ruby-lvm/0.1.3/di-ruby-lvm-0.1.3.gem"
  checksum 'f20e29a4'
end

gem_package 'open4' do
  source "#{Chef::Config['file_cache_path']}/open4-1.3.4.gem"
  version '1.3.4'
  action :install
end
gem_package 'di-ruby-lvm-attrib' do
  source "#{Chef::Config['file_cache_path']}/di-ruby-lvm-attrib-0.0.16.gem"
  version '0.0.16'
  action :install
end
gem_package 'di-ruby-lvm' do
  source "#{Chef::Config['file_cache_path']}/di-ruby-lvm-0.1.3.gem"
  version '0.1.3'
  action :install
end

