
Chef::Log.info("Getting monsoon friendly name")

ruby_block "get_monsoon_friendly_name" do
  block do
  
    monsoon_facts = MonsoonFacts.new(node["platform_family"])
    
    fqdn = monsoon_facts.getFQDN(node['saas_zabbix']['domain'])
    
    if fqdn!=nil and fqdn.empty?()==false then       
        node.override['sap-zabbix']['agent']['zabbixAgentdConf']['HostMetadata'] = fqdn
    end
    
    node.override['sap-zabbix']['agent']['zabbixAgentdConf']['Hostname'] = node['hostname']
    
    #needed for sap-zabbix 0.2.1 and below
    #node.override['sap-zabbix']['agent']['zabbixAgentdConf']['ListenIP'] = node['ipaddress']
       
    #had to include_recipe inside ruby block so it run in the convergence/execute phase instead of compile phase so the fqdn is being picked up
    run_context.include_recipe "sap-zabbix"
    
  end #end block
end #end ruby_block


