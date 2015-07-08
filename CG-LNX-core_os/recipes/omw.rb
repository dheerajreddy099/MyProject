#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: omw
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#

remote_file '/OMW.tar.gz' do
  source "http://#{node['pkgdist_server']}/pkgdist/linux/omw/OMW.tar.gz"
  notifies :run, 'bash[Extract OMW]', :immediately
  not_if '/sbin/chkconfig --list OVCtrl > /dev/null 2>&1'
end

bash 'Extract OMW' do
  user 'root'
  cwd '/'
  code <<-EOH
     tar xvzf OMW.tar.gz
     rm OMW.tar.gz
  EOH
  notifies :run, 'bash[Install OMW]', :immediately
  only_if { ::File.exist?('/OMW.tar.gz') }
  action :nothing
end

bash 'Install OMW' do
  user 'root'
  cwd '/OMW'
  code <<-EOH
./oainstall.sh -i -a
/opt/OV/bin/oalicense -set -type PERMANENT "HP Operations OS Inst Adv SW LTU"
/opt/OV/bin/oalicense -set -type PERMANENT "Glance Software LTU"
rm -rf /OMW
  EOH
  only_if { ::File.exist?('/OMW/oainstall.sh') }
  action :nothing
end

%w(lic.dat reslic.dat).each do |licfile|
  file "/var/opt/OV/datafiles/sec/lic/#{licfile}" do
    mode 00644
    owner 'root'
    group 'bin'
  end
end

# This isn't working ... Not sure how to ensure service is running
service 'ovpa' do
  pattern 'scopeux'
  supports status: false
  action [:enable, :start]
end

