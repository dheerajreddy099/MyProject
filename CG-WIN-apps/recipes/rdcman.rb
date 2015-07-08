#
# Cookbook Name:: *Cookbook_Name*
# Recipe:: *Application_Name*
#
# Copyright 2014, Capital Group
#
# All rights reserved - Do Not Redistribute
#

# Required for windows unzip
include_recipe 'CG-ALL-chefgems::rubyzip'

# Required for PS helper modules
include_recipe 'CG-WIN-ps_modules'

# ======================================== #
#   Start of Templated recipe parameters   #
# ======================================== #

# Set PowerShell and DSC script variables
ps_script_cwd    = node['CG-WIN-apps']['ps_script_path']
dsc_script_cwd   = node['CG-WIN-apps']['dsc_script_path']
setup_cwd        = node['CG-WIN-apps']['RDCMan']['script_folder']

dsc_script       = node['CG-WIN-apps']['RDCMan']['dsc_script']
dsc_config       = node['CG-WIN-apps']['RDCMan']['dsc_config']

install_script   = node['CG-WIN-apps']['RDCMan']['install_script']
guard_script     = node['CG-WIN-apps']['RDCMan']['guard_script']

setup_folder     = node['CG-WIN-apps']['RDCMan']['setup_folder']
logs_folder      = node['CG-WIN-apps']['RDCMan']['logs_folder']
# script_log       = "#{logs_folder}\\#{node['CG-WIN-apps']['RDCMan']['software_title']}_script.log"

# Set software installation folder & path variables
software_title   = node['CG-WIN-apps']['RDCMan']['software_title']
software_version = node['CG-WIN-apps']['RDCMan']['software_version']

installer_folder = node['CG-WIN-apps']['RDCMan']['installer_folder']

installer_path   = "#{setup_folder}\\#{installer_folder}"

# Set source archive variables
archive_folder   = node['CG-WIN-apps']['RDCMan']['archive_folder']
archive_file     = node['CG-WIN-apps']['RDCMan']['archive_file']
archive_checksum = node['CG-WIN-apps']['RDCMan']['archive_checksum']
archive_path     = "#{archive_folder}/#{archive_file}"

artifact_server  = "http://#{node['CG']['artifact_server']}"

# Set copy destination archive variables
archive_cache    = "#{Chef::Config[:file_cache_path]}"
software_archive = "#{archive_cache}\\#{archive_file}"

# ====================================== #
#   End of Templated recipe parameters   #
# ====================================== #

# ============================================= #
#   Start software package specific variables   #
# ============================================= #

# No software specific resources

# =========================================== #
#   End software package specific variables   #
# =========================================== #

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

# Delete powershell install script
file "Delete_#{install_script}" do
  path "#{setup_cwd}\\#{install_script}"
  action :delete
end

# ============================== #
#   End software files cleanup   #
# ============================== #

# ============================= #
#   Start software deployment   #
# ============================= #

# Copy archive file to local Chef cache directory
remote_file archive_file do
  source "#{artifact_server}/#{archive_path}"
  path "#{software_archive}"
  checksum archive_checksum
  action :create

  # Notify powershell resource to delete older extracted folder\files if new archive is downloaded
  notifies :unzip, "windows_zipfile[#{software_archive}]", :immediately

  # Check to see if software is installed, will trigger rest of recipe resource to execute
  guard_interpreter :powershell_script
  not_if "#{ps_script_cwd}\\#{guard_script} -title \"#{software_title}\" -version \"#{software_version}\""
end

# Unzip archive to tools folder
windows_zipfile software_archive do
  path setup_folder
  source software_archive
  action :nothing

  # Notify file delete resource to clean up archive
  notifies :delete, "file[Delete_#{software_archive}]", :immediately
  
  # Notify custom app resourses
  # No custom app resources

  # Notify cookbook_file resource to deploy install script
  notifies :create, "cookbook_file[#{install_script}]", :immediately
end

# Custom application resource
# No custom app resource

# Copy install PS script over to c:\CG\Setup folder for execution
cookbook_file install_script do
  path "#{setup_cwd}/#{install_script}"
  action :nothing

  # Notify installation script
  notifies :run, "powershell_script[#{install_script}]", :immediately
end

# Execute PowerShell script
powershell_script install_script do
  cwd "#{setup_cwd}"
  code "#{setup_cwd}\\#{install_script} -title \"#{software_title}\" -version \"#{software_version}\" -setup_folder \"#{installer_folder}\" -setup_path \"#{setup_folder}\""
  timeout 1200
  action :nothing

  # Notify folder resource to delete install source folder for cleanup
  notifies :delete, "directory[Delete_#{installer_path}]", :immediately
  # Notify file resource to delete installation script for cleanup
  notifies :delete, "file[Delete_#{install_script}]", :immediately
end

# Copy DSC script over to c:\CG\Setup folder for execution
# cookbook_file dsc_script do
#   path "#{dsc_script_cwd}/#{dsc_script}"
# end

# Execute DSC script to enforce application specific settings
# dsc_script dsc_config do
#   cwd dsc_script_cwd
#   configuration_name dsc_config
#   command "#{dsc_script_cwd}/#{dsc_script}"
# end

# =========================== #
#   End software deployment   #
# =========================== #
