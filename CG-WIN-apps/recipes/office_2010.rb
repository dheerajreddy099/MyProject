#
# Cookbook Name:: CG-WIN-apps
# Recipe:: Office_2010
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#

# Required for windows unzip
include_recipe 'CG-ALL-chefgems::rubyzip'

# Set PowerShell script variables
ps_cwd = node['CG-WIN-apps']['dsc_script_path']

ps_install_script = 'CG-WIN-office_2010_install.ps1'
ps_check_script   = 'CG-WIN-office_2010_check.ps1'

# Set software installation folder & path variables
cg_setup_path            = 'c:\CG\Setup'
cg_setup_install_folder  = 'Office2010Source'
cg_setup_install_path    = "#{cg_setup_path}\\#{cg_setup_install_folder}"

# Set artifact server archive variables
artifact_server  = "http://#{node['CG']['artifact_server']}"

archive_location = 'pkgdist/windows/apps'
archive_file     = 'Office2010Source.zip'
archive_path     = "#{archive_location}/#{archive_file}"
archive_checksum = '74c7561a2aea99b6472cba346825dc7eb743d4499ae2945b742a533d6503109e'

# Admin file variables
office_admin_file     = 'Office2010_Excel_Word.msp'
office_admin_checksum = 'a7b97a58e408af7e93f9f40973c12cc74c25fef1ed843c5da3aaa1e828ca9a32'

# Config file variables
office_config_file     = 'MS-Office_Setup_Config-AdminE.xml'

# Set copy destination variables
chef_cache_path    = "#{Chef::Config[:file_cache_path]}"
archive_cache_path = "#{chef_cache_path}\\#{archive_file}"

admin_destination_path  = "#{cg_setup_path}\\#{cg_setup_install_folder}\\#{office_admin_file}"
config_destination_path = "#{cg_setup_path}\\#{cg_setup_install_folder}\\#{office_config_file}"

# Copy check PS script over to c:\CG\Setup folder for execution
cookbook_file ps_check_script do
  path "#{ps_cwd}/#{ps_check_script}"
end

# Delete install script if exists from previous run
# Necessary for notification on installation sequence
file "Delete_#{ps_install_script}" do
  path "#{ps_cwd}\\#{ps_install_script}"
  action :delete
end

# Deploy Office Installation Files

# Copy archive file to local Chef cache directory
remote_file archive_file do
  source "#{artifact_server}/#{archive_path}"
  path "#{archive_cache_path}"
  checksum archive_checksum
  action :create

  # Notify powershell resource to delete older extracted folder\files if new archive is downloaded
  notifies :run, "powershell_script[Delete_#{cg_setup_install_path}]", :immediately
  notifies :unzip, "windows_zipfile[#{archive_cache_path}]", :immediately

  # Check to see if Office 2010 is installed
  guard_interpreter :powershell_script
  not_if "#{ps_cwd}\\#{ps_check_script}"
end

# Delete extracted setup folder if newer archive file has been downloaded
# Resource gets triggered on notify from remote_file archive_file
powershell_script "Delete_#{cg_setup_install_path}" do
  cwd cg_setup_path
  code <<-EOH
    Remove-Item \"#{cg_setup_install_folder}\" -recurse
  EOH
  action :nothing

  # Check to see if target directory exists
  guard_interpreter :powershell_script
  only_if "test-path \"#{cg_setup_install_path}\""
end

# Unzip Archive to tools folder
windows_zipfile archive_cache_path do
  path cg_setup_path
  source archive_cache_path
  action :nothing

  # Notify file copy resources to execute
  notifies :create, "remote_file[#{admin_destination_path}]", :immediately
  notifies :create, "cookbook_file[#{office_config_file}]", :immediately
end

# Delete archive after Unzip
file "Delete_#{archive_cache_path}" do
  path archive_cache_path
  action :delete
end

# Copy office_admin_file to cg_setup_install_folder
remote_file admin_destination_path do
  source "#{artifact_server}/#{archive_location}/#{office_admin_file}"
  checksum office_admin_checksum
  action :nothing
end

# Copy office_config_file over to cg_setup_install_folder
cookbook_file office_config_file do
  path config_destination_path
  action :nothing
end

# Execute recipe

# Copy Office Install PS script over to c:\CG\Setup folder for execution
cookbook_file ps_install_script do
  path "#{ps_cwd}/#{ps_install_script}"

  # Notify installation script
  notifies :run, "powershell_script[#{ps_install_script}]", :immediately

  # Check to see if software is installed
  guard_interpreter :powershell_script
  not_if "#{ps_cwd}\\#{ps_check_script}"
end

# Execute PowerShell script
powershell_script ps_install_script do
  cwd "#{ps_cwd}"
  code "#{ps_cwd}\\#{ps_install_script}"
  timeout 1200

  action :nothing

  # Notify powershell resource to delete extracted folder\files for cleanup
  notifies :run, "powershell_script[Delete_#{cg_setup_install_path}]", :immediately
  notifies :delete, "file[Delete_#{ps_install_script}]", :immediately

  # Check to see if Office 2010 is installed
  guard_interpreter :powershell_script
  not_if "#{ps_cwd}\\#{ps_check_script}"
end
