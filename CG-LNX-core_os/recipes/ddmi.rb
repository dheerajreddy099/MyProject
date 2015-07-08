#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: ddmi
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#

package 'cg-ddmi' do
  action :install
end

user 'ddmaadm' do
  uid 7629
  gid 'ddmaadm'
  home '/users/home/ddmaadm'
  shell '/usr/bin/ksh'
  password 'PupgAsiSGpFfI'
end

# This does not appear to work ... Will revisit later
service 'ddmi-agent-lnx' do
  supports status: false
  pattern 'discagnt'
  action :start
end
