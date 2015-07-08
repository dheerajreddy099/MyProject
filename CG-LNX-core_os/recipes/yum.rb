#
# Cookbook Name:: CG-LNX-core_os
# Recipe:: yum
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#
#
#
# execute 'create-yum-cache' do
#  command 'yum -q makecache'
#  action :nothing
# end

#ruby_block 'reload-internal-yum-cache' do
#  block do
#    Chef::Provider::Package::Yum::YumCache.instance.reload
#  end
#  action :nothing
#end

node['CG-LNX-core_os']['yumrepos'].each do |repo, repo_data|
  template "/etc/yum.repos.d/#{repo}.repo" do
    source 'yum/rhel.repo.erb'
    mode 00644
    variables(
      :repositoryid => repo,
      :name => repo,
      :baseurl => repo_data['baseurl'],
      :enabled => repo_data['enabled'],
      :gpgcheck => repo_data['gpgcheck'],
      :gpgkey => repo_data['gpgkey']
    )
  #  notifies :run, 'execute[create-yum-cache]', :immediately
  #  notifies :create, 'ruby_block[reload-internal-yum-cache]', :immediately
  end
end
