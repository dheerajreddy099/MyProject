#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: saas_wfa_sql_server
# Attribute:: default
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
#

default['saas_wfa_sql_server']['accept_eula'] = 'true'
default['saas_wfa_sql_server']['product_key'] = 'JD8Y6-HQG69-P9H84-XDTPG-34MBB'
default['saas_wfa_sql_server']['version'] = '2008R2'

case node['saas_wfa_sql_server']['version']
when '2008R2'
  default['saas_wfa_sql_server']['reg_version'] = 'MSSQL10_50.'
when '2012'
  default['saas_wfa_sql_server']['reg_version'] = 'MSSQL11.'
end
