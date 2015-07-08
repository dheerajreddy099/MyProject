#######################
### Validate input ####
#######################

JSON::Validator.validate!("#{run_context.cookbook_collection[cookbook_name].root_dir}/schema/saas_zookeeper.json", node["saas_zookeeper"].to_json)

#######################
### User ##############
#######################

saas_user "zookeeper" do
  action :create
end

zookeeper_user  = SaasUser["zookeeper"]["id"]
zookeeper_group = SaasUser["zookeeper"]["primary_group"]
zookeeper_home  = SaasUser["zookeeper"]["home_directory"]

file ".bashrc" do
  action :create_if_missing
  path "/app/home/zookeeper/.bashrc"
  owner zookeeper_user
  group zookeeper_group
  mode  0644  
end

cookbook_file ".bashrc.zookeeper" do
  action :create
  source "bashrc.zookeeper"    
  path "/app/home/zookeeper/.bashrc.zookeeper"
  owner zookeeper_user
  group zookeeper_group
  mode  0644  
end

ruby_block "insert_bashrc" do
  block do
    file = Chef::Util::FileEdit.new("/app/home/zookeeper/.bashrc")
    file.insert_line_if_no_match(/source .bashrc.zookeeper/,"source .bashrc.zookeeper");
    file.write_file
  end
end

#######################
### Java ##############
#######################

package "sapjvm_7" do
  action :install
end

######################################
### Prepare directories ##############
######################################

directory "/app/zookeeper" do
  action :create
  owner zookeeper_user
  group zookeeper_group
end

directory "/app/zookeeper/data" do
  action :create
  owner zookeeper_user
  group zookeeper_group
end

directory "/app/zookeeper/log" do
  action :create
  owner zookeeper_user
  group zookeeper_group
end

directory "/app/zookeeper/conf" do
  action :create
  owner zookeeper_user
  group zookeeper_group
end

#########################################
### Zookeeper distribution ##############
#########################################

tar_package "#{node["saas"]["repo"]["main"]}/bizx/files/zookeeper-#{node["saas_zookeeper"]["version"]}.tar.gz" do
  path "/app/zookeeper/dist"
  strip_dirs 1
  owner zookeeper_user
  group zookeeper_group
  version node["saas_zookeeper"]["version"]
  notifies :restart, "service[zookeeper]"
end

#########################################
### Configuration #######################
#########################################

cookbook_file "jaas_client.conf" do
  action :create
  source "jaas_client.conf"  
  path "/app/zookeeper/conf/jaas_client.conf"
  owner zookeeper_user
  group zookeeper_group
  mode  0644
  notifies :restart, "service[zookeeper]"  
end

cookbook_file "jaas_server.conf" do
  action :create
  source "jaas_server.conf"  
  path "/app/zookeeper/conf/jaas_server.conf"
  owner zookeeper_user
  group zookeeper_group  
  mode  0644
  notifies :restart, "service[zookeeper]"  
end  

template "zoo_sf.cfg" do
  action :create
  source "zoo_sf.cfg.erb"
  path "/app/zookeeper/conf/zoo_sf.cfg"
  owner zookeeper_user
  group zookeeper_group
  mode  0644 
  notifies :restart, "service[zookeeper]"  
end  

template "start_sf.sh" do
  action :create
  source "start_sf.sh.erb"
  path "/app/zookeeper/conf/start_sf.sh"
  owner zookeeper_user
  group zookeeper_group
  mode  0755 
  notifies :restart, "service[zookeeper]"  
end  

file "myid" do
  action :create  
  path "/app/zookeeper/data/myid"
  content node["saas_zookeeper"]["id"]
  owner zookeeper_user
  group zookeeper_group
  mode  0644   
  notifies :restart, "service[zookeeper]"  
end

#############################################
### Startup script and service ##############
#############################################

cookbook_file "zookeeper" do
  action :create  
  source "zookeeper"  
  path "/etc/init.d/zookeeper"
  owner "root"
  group "root"
  mode  0755
  notifies :restart, "service[zookeeper]"  
end

service "zookeeper" do
  action [:enable,:start]
end