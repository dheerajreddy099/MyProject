#
# Cookbook Name:: CG-WIN-apps
# Recipe:: sccm
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#

# Set PowerShell DSC script to execute
dsc_script_name = 'CG-WIN-office_2010.ps1'
dsc_config_name = 'Word_2010'
dsc_exec_dir    = node['CG-WIN-apps']['dsc_script_path']

# Archive variables
archive_location  = 'windows/apps'
archive_file      = 'Word_2010.zip'
archive_checksum  = '59471e44948278348983895bd1f6f85fb36fceddb38383ee23e3d9f389ec9836'

archive_path = "#{archive_location}/#{archive_file}"

# Copy destination
archive_destination_path = "#{Chef::Config[:file_cache_path]}\\#{archive_file}"

# Execute recipe

# Copy archive file to local Chef cache directory
remote_file archive_destination_path do
  source "http://#{node['CG']['artifact_server']}/pkgdist/#{archive_path}"
  checksum archive_checksum
end

dsc_script "unzip_#{dsc_config_name}" do
  code <<-EOH
    Archive #{dsc_config_name}
    {
      Ensure = 'Present'
      Path = "#{archive_destination_path}"
      Destination = "c:/CG/Setup"
    }
  EOH
end

# Copy DSC script over to c:\CG\Setup folder for execution
cookbook_file dsc_script_name do
  path "#{node['CG-WIN-apps']['dsc_script_path']}/#{dsc_script_name}"
end

# Execute DSC script
dsc_script dsc_config_name do
  configuration_name dsc_config_name
  command "#{dsc_exec_dir}/#{dsc_script_name}"
  cwd dsc_exec_dir
end
