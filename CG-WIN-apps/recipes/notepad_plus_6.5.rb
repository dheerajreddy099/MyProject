#
# Cookbook Name:: CG-WIN-apps
# Recipe:: notepad_plus_6.5
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#

# Required for windows unzip
#include_recipe 'CG-ALL-chefgems::rubyzip'

# Required for PS helper modules
#include_recipe 'CG-WIN-ps_modules'

# ======================================== #
#   Start of Templated recipe parameters   #
# ======================================== #

# Set PowerShell and DSC script variables
ps_script_cwd    = node['CG-WIN-apps']['ps_script_path']
setup_cwd        = node['CG-WIN-apps']['notepad_plus_6.5']['script_folder']       # 'c:\CG\Setup'
guard_script     = node['CG-WIN-apps']['notepad_plus_6.5']['guard_script']        # 'Get-InstalledSoftware.ps1'
setup_folder     = node['CG-WIN-apps']['notepad_plus_6.5']['setup_folder']        # 'c:\CG\Setup'
logs_folder      = node['CG-WIN-apps']['notepad_plus_6.5']['logs_folder']         # 'c:\CG\Logs'
# script_log       = "#{logs_folder}\\#{node['CG-WIN-apps']['notepad_plus_6.5']['software_title']}_script.log"

# Set software installation folder & path variables
software_title   = node['CG-WIN-apps']['notepad_plus_6.5']['software_title']      # 'Mozilla notepad'
software_version = node['CG-WIN-apps']['notepad_plus_6.5']['software_version']    # '37'

installer_folder = node['CG-WIN-apps']['notepad_plus_6.5']['installer_folder']    # 'notepad'

installer_path   = "#{setup_folder}\\#{installer_folder}"                   # 'c:\\CG\\Setup\\notepad'     

# Set source archive variables
archive_folder   = node['CG-WIN-apps']['notepad_plus_6.5']['archive_folder']      # 'pkgdist/windows/server_tools'
archive_file     = node['CG-WIN-apps']['notepad_plus_6.5']['archive_file']        # 'notepad.zip'
archive_checksum = node['CG-WIN-apps']['notepad_plus_6.5']['archive_checksum']    # 
archive_path     = "#{archive_folder}/#{archive_file}"                      # pkgdist/windows/server_tools/notepad.zip

artifact_server  = "http://#{node['CG']['artifact_server']}"                # http://127.0.0.1

# Set copy destination archive variables
archive_cache    = "#{Chef::Config[:file_cache_path]}"                      # generally C:\\chef\\cache
software_archive = "#{archive_cache}\\#{archive_file}"                      # C:\\chef\\cache\\notepad.zip

# ====================================== #
#   End of Templated recipe parameters   #
# ====================================== #

# ================================ #
#   Start software files cleanup   #
# ================================ #

# Delete archive file in chef cache folder
file "Delete_#{software_archive}" do
  path software_archive
  action :delete
end

# Delete installation source folder
directory "Delete_#{installer_path}" do
  path installer_path
  recursive true
  action :delete
end

# ============================== #
#   End software files cleanup   #
# ============================== #

# ============================= #
#   Start software deployment   #
# ============================= #

#create configuration file from template (uncomment below block when using configuration.ini file for installation)
#config_file_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], "notepad.ini"))
#template config_file_path do
# source "notepad.ini.erb"
#end


# Copy archive file to local Chef cache directory
remote_file archive_file do
  source "#{artifact_server}/#{archive_path}"              # http://127.0.0.1/pkgdist/windows/server_tools/notepad.zip
  path "#{software_archive}"                               # C:\\chef\\cache\\notepad.zip
  checksum archive_checksum
  action :create
#cookbook_file "notepad.zip" do
#  path "C:\\chef\\cache\\notepad.zip"
  # Notify powershell resource to delete older extracted folder\files if new archive is downloaded
  notifies :unzip, "windows_zipfile[#{software_archive}]", :immediately
  # Check to see if software is installed, will trigger rest of recipe resource to execute
  guard_interpreter :powershell_script
  not_if "#{ps_script_cwd}\\#{guard_script} -title \"#{software_title}\" -version \"#{software_version}\""
end

# Unzip archive to tools folder
windows_zipfile software_archive do
  path installer_path
  source software_archive
  action :nothing
  # Notify file delete resource to clean up archive
  notifies :delete, "file[Delete_#{software_archive}]", :immediately
  # Notify windows_package resource to install package
  notifies :install, "windows_package[#{software_title}]", :immediately
end


# package install
windows_package software_title  do
  source "#{installer_path}\\notepad++.msi"
  action :nothing
  # Notify folder resource to delete install source folder for cleanup
  notifies :delete, "directory[Delete_#{installer_path}]", :immediately
end

# =========================== #
#   End software deployment   #
# =========================== #
