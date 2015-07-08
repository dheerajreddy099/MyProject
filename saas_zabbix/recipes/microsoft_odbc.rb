#install the packages, have to force install using rpm for it to work

ruby_block "install_microsoft_odbc" do
    block do
        result=`rpm -q #{node['saas_zabbix']['microsoftodbc']['packageName']}`
        if result==nil or result.empty?()==true or result.include?("#{node['saas_zabbix']['microsoftodbc']['packageName']}-#{node['saas_zabbix']['microsoftodbc']['version']}")==false then
            command = "rpm -i --force --nodeps #{node['saas_zabbix']['microsoftodbc']['packageSource']}"
            Chef::Log.info "installing #{node['saas_zabbix']['microsoftodbc']['packageName']}-#{node['saas_zabbix']['microsoftodbc']['version']}"
            system(command)
        else
            Chef::Log.info "#{node['saas_zabbix']['microsoftodbc']['packageName']}-#{node['saas_zabbix']['microsoftodbc']['version']} is already installed"
        end
    end
    action :run
end