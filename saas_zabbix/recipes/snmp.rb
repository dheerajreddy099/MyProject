#install the packages
node['saas_zabbix']['snmp']['requiredPackages'].each do |package_name,version_num|
    package "#{package_name}" do
      if version_num != nil then
           version version_num
      end
      action :install
    end
end
  
package node['saas_zabbix']['snmp']['packageName'] do
    if node['saas_zabbix']['snmp']['version'] != nil then
       version node['saas_zabbix']['snmp']['version']
    end
    action :install
end

#config file
template node['saas_zabbix']['snmp']['config']  do
    source node['saas_zabbix']['snmp']['configTemplate'] 
    mode '0644'
    owner 'root'
    group 'root'
    variables   ({    
            :configDir => node['saas_zabbix']['snmp']['configDir']
     })
end

#ensure all config directories have the proper permission
node['saas_zabbix']['snmp']['configDirList'].each do |dir|
    directory dir do
      owner 'root'
      group 'root'
      mode '0755'
      action :create
    end
end


#start the service
service node['saas_zabbix']['snmp']['serviceName'] do
  action [:enable, :start]
end