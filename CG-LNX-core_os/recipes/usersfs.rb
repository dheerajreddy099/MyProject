#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: fstest
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#
lvm_volume_group 'vgdata' do
  physical_volumes ['/dev/sdb1']

  logical_volume 'users' do
    size	'100%VG'
    filesystem 'ext4'
    mount_point location: '/users'
    action [:create, :resize]
  end
end

# lvm_logical_volume 'test2' do
#  group       'vgdata'
#  size        '2G'
#  filesystem  'ext4'
#  mount_point '/users/test2'
#  action [:create, :resize]
# end

