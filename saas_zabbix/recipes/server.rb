if node["platform"] == "suse"

    ruby_block "install_sap_zabbix" do
      block do
         
        #had to include_recipe inside ruby block so it run in the convergence/execute phase instead of compile phase so that everything is being picked up
        run_context.include_recipe "sap-zabbix"
        run_context.include_recipe "sap-zabbix::server"
        
        run_context.include_recipe "saas_zabbix::unixodbc"
        run_context.include_recipe "saas_zabbix::microsoft_odbc"
        run_context.include_recipe "saas_zabbix::snmp"

      end #end block
    end #end ruby_block

    
    #for sap-zabbix 0.2.2 and below
    package "fping" do
        action :install
    end
    
    file "/usr/sbin/fping" do 
        owner "root"
        group "zabbix"
        mode "4710"
    end
else
  Chef::Log.info "#{node['platform']} is not supported yet."
end