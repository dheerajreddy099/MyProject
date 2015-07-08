# For installing CG-created packages, not related to a particular product

# CG OS scripts
remote_file "#{Chef::Config[:file_cache_path]}/cg-osscripts-1.0-10.x86_64.rpm" do
  source "http://#{node['CG']['artifact_server']}/pkgdist/linux/cgpkgs/cg-osscripts-1.0-10.x86_64.rpm"
  not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/cg-osscripts-1.0-10.x86_64.rpm") }
end
package 'cg-osscripts' do
  source "#{Chef::Config[:file_cache_path]}/cg-osscripts-1.0-10.x86_64.rpm"
  action :install
end
service 'VMWare_cfg' do
  action [:enable]
end
service 'Zsyscheck' do
  action [:enable]
end
remote_file "#{Chef::Config[:file_cache_path]}/cg-sdmigr-1.1-1.x86_64.rpm" do
  source "http://#{node['CG']['artifact_server']}/pkgdist/linux/cgpkgs/cg-sdmigr-1.1-1.x86_64.rpm"
  not_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/cg-sdmigr-1.1-1.x86_64.rpm") }
end
rpm_package 'cg-sdmigr' do
  source "#{Chef::Config[:file_cache_path]}/cg-sdmigr-1.1-1.x86_64.rpm"
  version '1.1'
  action :upgrade
end

# add directory resource to set owner on /home/sdmigr - after sdmigr account is created in centrify