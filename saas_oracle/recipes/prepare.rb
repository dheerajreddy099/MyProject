directory "/app/home" do
  action :create
  owner "root"
  group "root"
  mode "0755"
end

saas_user "oracle" do
  home_directory "/app/home/oracle"
  password node["saas_oracle"]["password"]
end  

file ".bashrc.oracle" do
  path "/app/home/oracle/.bashrc.oracle"
  mode "0644"
  owner "oracle"
  group "oinstall"  
  action :create_if_missing
end

file ".bashrc" do
  path "/app/home/oracle/.bashrc"
  mode "0644"
  owner "oracle"
  group "oinstall"  
  action :create_if_missing
end

ruby_block "insert_oracle" do
  block do
    file = Chef::Util::FileEdit.new("/app/home/oracle/.bashrc")
    file.insert_line_if_no_match(/source .bashrc.oracle/,"source .bashrc.oracle");
    file.write_file
  end
end

