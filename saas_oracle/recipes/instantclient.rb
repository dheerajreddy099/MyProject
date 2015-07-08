package "oracle-instantclient11.2-basic" do
  action :upgrade
  version node["saas_oracle"]["version"]
end
  
package "oracle-instantclient11.2-sqlplus" do
  action :upgrade
  version node["saas_oracle"]["version"]      
end
  
package "oracle-instantclient11.2-devel" do
  action :upgrade
  version node["saas_oracle"]["version"]      
end


