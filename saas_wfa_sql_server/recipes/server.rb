#
# Author:: Pradeep Kumar Mohan (pradeep.kumar.mohan@sap.com)
# Cookbook Name:: saas_wfa_sql_server
# Recipe:: server
#
# Copyright:: 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

service_name = node['saas_wfa_sql_server']['instance_name']
if node['saas_wfa_sql_server']['instance_name'] == 'SQLEXPRESS'
  service_name = "MSSQL$#{node['saas_wfa_sql_server']['instance_name']}"
end
  
static_tcp_reg_key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\\' + node['saas_wfa_sql_server']['reg_version'] +
  node['saas_wfa_sql_server']['instance_name'] + '\MSSQLServer\SuperSocketNetLib\Tcp\IPAll'

# generate and set a password for the 'sa' super user
node.set_unless['saas_wfa_sql_server']['server_sa_password'] = "#{secure_password}-aA12"
# force a save so we don't lose our generated password on a failed chef run
node.save unless Chef::Config[:solo]

config_file_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], "ConfigurationFile.ini"))

template config_file_path do
  source "#{node['saas_wfa_sql_server']['Server_type']}.ini.erb"
end

windows_zipfile "#{node['saas_wfa_sql_server']['server']['tempdir']}" do
  source "#{node['saas_wfa_sql_server']['server']['url']}"           # make a parameter
  action :unzip
  not_if {::File.exists?("#{node['saas_wfa_sql_server']['server']['tempdir']}\\SQLServer2008_FullSP2\\setup.exe")}
end

windows_package node['saas_wfa_sql_server']['server']['package_name'] do
  source "#{node['saas_wfa_sql_server']['server']['tempdir']}\\SQLServer2008_FullSP2\\setup.exe"
  installer_type :custom
  options "/Q /ConfigurationFile=#{config_file_path}"
  action :install
  timeout 3000
end

service service_name do
  stop_command "NET stop \"#{service_name}\" /Y"
  restart_command "NET stop \"#{service_name}\" /Y && NET start \"#{service_name}\""
  action :nothing
end

# set the static tcp port
registry_key static_tcp_reg_key do
  values [{ :name => 'TcpPort', :type => :string, :data => node['saas_wfa_sql_server']['port'].to_s },
    { :name => 'TcpDynamicPorts', :type => :string, :data => '' }]
	recursive true
  notifies :restart, "service[#{service_name}]", :immediately
end

