if node['saas_oracle']['base'] == "" then
  Chef::Application.fatal!("No valid Oracle base directory attribute provided")
end

if node['saas_oracle']['inventory'] == "" then
  Chef::Application.fatal!("No valid Oracle inventory directory attribute provided")
end

if node['saas_oracle']['home'] == "" then
  Chef::Application.fatal!("No valid Oracle home directory attribute provided")
end

if File.exists?("#{node['saas_oracle']['home']}/.version") then
  Chef::Application.fatal!("Oracle already installed in #{node['saas_oracle']['home']}; installation not possible")
end

template "/etc/oraInst.loc" do
  source "oraInst.loc.erb"
  owner "oracle"
  group "oinstall"
  mode "0644"
  variables({
     :oracle_inventory => node['saas_oracle']['inventory'],	   
  })
end

file "/etc/oratab" do
  action :create_if_missing
  owner "oracle"
  group "oinstall"
  mode "0644"
end  

directory "/app/home/oracle/response" do
  action :create
  owner "oracle"
  group "oinstall"
  mode "0755"
end

template "/app/home/oracle/response/database.rsp" do
  source "database-#{node['saas_oracle']['short_version']}.rsp.erb"
  owner "oracle"
  group "oinstall"
  mode "0644"
  variables({
    :oracle_base => node['saas_oracle']['base'],
    :oracle_inventory => node['saas_oracle']['inventory'],	 
	  :oracle_home => node['saas_oracle']['home'],
    :oracle_host => node['saas_oracle']['host'],
  })
end

directory node['saas_oracle']['base'] do
  action :create
  owner "oracle"
  group "oinstall"
  mode "0755"
end

directory node['saas_oracle']['inventory'] do
  action :create
  owner "oracle"
  group "oinstall"
  mode "0755"
end

bash "install-oracle" do
  timeout 86400
  code <<-EOH
    set -e
  
    function cleanup {
      if [ -d "$TMPDIR" ]; then  
        umount "$TMPDIR"
        rm -rf "$TMPDIR"
      fi
    }
    
    UUID=$(cat /proc/sys/kernel/random/uuid)
    if [ -z $UUID ]; then 
      echo "Error generating UUID"
      exit 1
    fi 
    TMPDIR="/$UUID"
    
    trap cleanup EXIT        
    mkdir "$TMPDIR"
    mount -t tmpfs -o size=8G,mode=0755 tmpfs "$TMPDIR"
    curl -s -S -f #{node['saas']['repo']['main']}/common/oracle/#{node['saas_oracle']['version']}/database.tar.gz | tar -C "$TMPDIR" -xz
    set +e
    sudo -u oracle -i "$TMPDIR"/database/runInstaller -silent -ignorePrereq -waitforcompletion -responseFile /app/home/oracle/response/database.rsp   
    EXITCODE=$?    
    if [ $EXITCODE -lt 0 ] || [ $EXITCODE -gt 3 ]; then 
      # exit codes between 0 and 3 are ok (check Oracle documentation)
      echo "Error in Oracle installer"
      exit $EXITCODE
    fi
    #{node['saas_oracle']['home']}/root.sh
  EOH
end

template "/app/home/oracle/.bashrc.oracle" do
  source ".bashrc.oracle.erb"
  owner "oracle"
  group "oinstall"
  mode "0644"
  variables({
     :oracle_base => node['saas_oracle']['base'],
	 :oracle_home => node['saas_oracle']['home']
  })
end

file "#{node['saas_oracle']['home']}/.version" do
  action :create
  content node['saas_oracle']['version']
  owner "oracle"
  group "oinstall"
end
