#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: nscd
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#
package 'sendmail' do
  action :install
end

package 'sendmail-cf' do
  action :install
end

template '/etc/mail/sendmail.cf' do
  source 'sendmail/sendmail.cf.erb'
  mode 00644
  owner 'root'
  group 'sys'
end

