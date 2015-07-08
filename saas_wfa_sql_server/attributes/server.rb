#
# Author:: Pradeep Kumar Mohan (pradeep.kumar.mohan@sap.com)
# Cookbook Name:: saas_wfa_sql_server
# Attribute:: server
#
# Copyright:: Copyright (c) 2011 Opscode, Inc.
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


default['saas_wfa_sql_server']['Server_type'] = 'oltpStandAlone' # to select the template file
default['saas_wfa_sql_server']['install_dir']    = 'C:\Program Files\Microsoft SQL Server'
default['saas_wfa_sql_server']['port']           = 1433

default['saas_wfa_sql_server']['instance_name']  = 'MSSQLSERVER'
default['saas_wfa_sql_server']['instance_dir']   = 'C:\Program Files\Microsoft SQL Server'
default['saas_wfa_sql_server']['shared_wow_dir']   = 'C:\Program Files (x86)\Microsoft SQL Server' 

default['saas_wfa_sql_server']['server']['tempdir'] = "C:"

#default['saas_wfa_sql_server']['failover_cluster_network_name']= 
#default['saas_wfa_sql_server']['agent_svc_account']=
#default['saas_wfa_sql_server']['sql_svc_account']=
#default['saas_wfa_sql_server']['full_text_svc_account']=
#default['saas_wfa_sql_server']['analysis_service_svc_account']=
#default['saas_wfa_sql_server']['failover_cluster_disks']=
#default['saas_wfa_sql_server']['failover_cluster_ipaddresses']=
#default['saas_wfa_sql_server']['integeration_service_svc_account']=
#default['saas_wfa_sql_server']['analysis_service_collation']=
#default['saas_wfa_sql_server']['analysis_service_datadir']=
#default['saas_wfa_sql_server']['analysis_service_logdir']=
#default['saas_wfa_sql_server']['analysis_service_backupdir']=
#default['saas_wfa_sql_server']['analysis_service_tempdir']=
#default['saas_wfa_sql_server']['analysis_service_configdir']=
#default['saas_wfa_sql_server']['analysis_service_sys_admin_accounts']=
#default['saas_wfa_sql_server']['sql_sys_admin_accounts']=
#default['saas_wfa_sql_server']['install_sql_data_dir']=
#default['saas_wfa_sql_server']['agent_svc_password']=
#default['saas_wfa_sql_server']['analysis_svc_password']=
#default['saas_wfa_sql_server']['sql_svc_password']=
#default['saas_wfa_sql_server']['sa_pwd']=


if kernel['machine'] =~ /x86_64/
  case node['saas_wfa_sql_server']['version']
  when '2008R2'
    default['saas_wfa_sql_server']['server']['url']          = 'http://repo:50000/repo/SuccessFactors/Operation/Deployment/WFA/SQLServer2008_FullSP2.zip'
    #default['saas_wfa_sql_server']['server']['checksum']     = '6840255cf493927a3f5e1d7f865b8409ed89133e3657a609da229bab4005b613'
    default['saas_wfa_sql_server']['server']['package_name'] = 'SQLServer2008_FullSP2'
  when '2012'
    default['saas_wfa_sql_server']['server']['url']          = 'http://repo:50000/repo/SuccessFactors/Operation/Deployment/WFA/SQLServer2008_FullSP2.zip'
    #default['saas_wfa_sql_server']['server']['checksum']     = '7f5e3d40b85fba2da5093e3621435c209c4ac90d34219bab8878e93a787cf29f'
    default['saas_wfa_sql_server']['server']['package_name'] = 'SQLServer2008_FullSP2'
  end

else
  case node['saas_wfa_sql_server']['version']
  when '2008R2'
    default['saas_wfa_sql_server']['server']['url']          = 'http://repo:50000/repo/SuccessFactors/Operation/Deployment/WFA/SQLServer2008_FullSP2.zip'
    #default['saas_wfa_sql_server']['server']['checksum']     = '24f75df802a406cf32e854a60b0c340a50865fb310c0f74c7cecc918cff6791c'
    default['saas_wfa_sql_server']['server']['package_name'] = 'SQLServer2008_FullSP2'
  when '2012'
    default['saas_wfa_sql_server']['server']['url']          = 'http://repo:50000/repo/SuccessFactors/Operation/Deployment/WFA/SQLServer2008_FullSP2.zip'
    #default['saas_wfa_sql_server']['server']['checksum']     = '9bdd6a7be59c00b0201519b9075601b1c18ad32a3a166d788f3416b15206d6f5'
    default['saas_wfa_sql_server']['server']['package_name'] = 'SQLServer2008_FullSP2'
  end

end
