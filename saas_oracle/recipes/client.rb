if node['saas_oracle']['base'] == "" then
  Chef::Application.fatal!("No valid Oracle base directory attribute provided")
end

if node['saas_oracle']['inventory'] == "" then
  Chef::Application.fatal!("No valid Oracle inventory directory attribute provided")
end

if node['saas_oracle']['version'] =~ /^(\d+\.\d+\.\d+)\.(\d+\.\d+)$/ then
  node.override['saas_oracle']['short_version'] = $1
else
  Chef::Application.fatal!("No valid Oracle version attribute provided")
end

node.override['saas_oracle']['home'] = "#{node['saas_oracle']['base']}/product/#{node['saas_oracle']['short_version']}/client_1"

include_recipe "saas_oracle::prepare"

if File.exists?("#{node['saas_oracle']['home']}/.version") then
  Chef::Log.info("Oracle already installed; skipping installation/upgrade")
else
  include_recipe "saas_oracle::client_install"
end


