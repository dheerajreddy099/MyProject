#install the packages
node['saas_zabbix']['unixodbc']['requiredPackages'].each do |package_name,version_num|
    package "#{package_name}" do
      if version_num != nil then
           version version_num
      end
      action :install
    end
end
  
package node['saas_zabbix']['unixodbc']['packageName'] do
    if node['saas_zabbix']['unixodbc']['version'] != nil then
       version node['saas_zabbix']['unixodbc']['version']
    end
    action :install
end

#config file
template node['saas_zabbix']['unixodbc']['odbcinstIniDestination']  do
    source node['saas_zabbix']['unixodbc']['odbcinstIniSource'] 
    mode '0644'
    owner 'root'
    group 'root'
    variables   ({    
            :oracleDriver => node['saas_zabbix']['unixodbc']['odbcinstIni']['oracleDriver'],
            :mssqlDriver => node['saas_zabbix']['unixodbc']['odbcinstIni']['mssqlDriver']
     })
end

if node['saas_zabbix']['unixodbc']['odbcIniSource']!=nil then
    remote_file "#{node['saas_zabbix']['unixodbc']['odbcIniDestination']}" do
       source node['saas_zabbix']['unixodbc']['odbcIniSource']
       action :create
       mode "0644"
       owner 'root'
       group 'root'
    end
end

if node['saas_zabbix']['unixodbc']['tnsnamesOraSource']!=nil then
    remote_file "#{node['saas_zabbix']['unixodbc']['tnsnamesOraDestination']}" do
       source node['saas_zabbix']['unixodbc']['tnsnamesOraSource']
       action :create
       mode "0644"
       owner 'root'
       group 'root'
    end
end