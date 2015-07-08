def whyrun_supported?
  true
end

use_inline_resources

def load_current_resource
  @current_resource = Chef::Resource::SaasUser.new(new_resource.username)

  passwd = `getent passwd #{new_resource.username}`
  if $?.exitstatus == 0 then
    passwd_fields = passwd.chomp.split(":")
    @current_resource.exists = true
    @current_resource.local = system("grep -e \"^#{new_resource.username}:\" /etc/passwd > /dev/null")
    @current_resource.uid = passwd_fields[2].to_i
    group = `getent group #{passwd_fields[3]}`
    Chef::Application.fatal!("Error: primary group of user #{new_resource.username} does not exist") if $?.exitstatus != 0
    group.chomp!
    @current_resource.primary_group = group.split(":")[0]
    @current_resource.username(new_resource.username)
    # todo: determine
    @current_resource.secondary_groups(nil)
    # todo: determine
    @current_resource.password(nil)
    @current_resource.home_directory(passwd_fields[5])
    @current_resource.shell(passwd_fields[6])
  else
    @current_resource.exists = false
  end
end

def check_uid(username,uid)
  #necessary because the non_unique feature is not yet supported by the user resource
  
  passwd = `getent passwd #{uid}`
  if $?.exitstatus == 0 then
    passwd_fields = passwd.chomp.split(":")
    Chef::Application.fatal!("Error: UID #{uid} already used by user #{passwd_fields[0]}") if passwd_fields[0] != username
  end
end

action :create do
  # check that user is defined as SaaS user
  saas_user = Chef::SaasUser[new_resource.username]
  Chef::Application.fatal!("Error: SaaS user #{new_resource.username} not defined") if saas_user.nil?

  # initialize attributes
  uid = saas_user["uid"]
  Chef::Application.fatal!("Error: no user ID provided") if uid.nil?

  primary_group = saas_user["primary_group"]
  Chef::Application.fatal!("Error: no primary group provided") if primary_group.nil? || primary_group == ""

  secondary_groups = []
  if saas_user["secondary_groups"] then
    secondary_groups.concat(saas_user["secondary_groups"])
  end
  if new_resource.secondary_groups then
    secondary_groups.concat(new_resource.secondary_groups)
  end
  secondary_groups.uniq!

  if new_resource.password then
    password = new_resource.password
  elsif saas_user["password"]
    password = saas_user["password"]
  else
    password = "!"
  end
  password = "!" if password.nil? || password == ""

  if new_resource.home_directory then
    home_directory = new_resource.home_directory
  elsif saas_user["home_directory"]
    home_directory = saas_user["home_directory"]
  else
    home_directory = ""
  end
  Chef::Application.fatal!("Error: no home directory provided") if home_directory.nil? || home_directory == ""

  if new_resource.shell then
    shell = new_resource.shell
  elsif saas_user["shell"]
    shell = saas_user["shell"]
  else
    shell = "/bin/bash"
  end
  Chef::Application.fatal!("Error: no shell provided") if shell.nil? || shell  == ""

  authorized_keys = []
  if saas_user["authorized_keys"]then
    authorized_keys.concat(saas_user["authorized_keys"])
  end
  if new_resource.authorized_keys then  
    authorized_keys.concat(new_resource.authorized_keys)
  end
  authorized_keys.uniq!
  
  # adjust attributes if user exists
  if current_resource.exists then
    if uid != current_resource.uid then
      Chef::Log.warn("Warning: user #{new_resource.username} already exists with different uid - not changing uid")
      uid = current_resource.uid
    end

    if primary_group != current_resource.primary_group then
      Chef::Log.warn("Warning: user #{new_resource.username} already exists with different primary group - not changing primary group")
      primary_group = current_resource.primary_group
    end

    if home_directory != current_resource.home_directory then
      Chef::Log.warn("Warning: user #{new_resource.username} already exists with different home directory - not changing home directory")
      home_alias = home_directory
      home_directory = current_resource.home_directory
    end
  end

  # create/adjust user
  if current_resource.exists && !current_resource.local then
    Chef::Log.warn("Warning: user #{new_resource.username} is not local - not touching anything")
  else
    if Chef::SaasGroup.exists?(primary_group) then
      saas_group primary_group
    end

    check_uid(new_resource.username,uid) 
    
    user new_resource.username do
      action :create
      supports :manage_home => true
      uid uid
      gid primary_group
      password password
      home home_directory
      shell shell
    end
  end
  
  # create secondary groups (if managed by SaaS) and insert user into secondary groups
  secondary_groups.each do |secondary_group|
    if Chef::SaasGroup.exists?(secondary_group) then
      saas_group secondary_group
    end

    g = group secondary_group do
      action :modify
      append true
      members [new_resource.username]
      only_if "grep -e \"^#{secondary_group}:\" /etc/group"
    end
  end

  # try to set link for home directory
  if home_alias && !Dir.exists?(home_alias) then
    ruby_block home_alias do
      block do
        if Dir.exists?(current_resource.home_directory) then
          FileUtils.ln_s(home_directory,home_alias)
          new_resource.updated_by_last_action(true)
        else
          Chef::Application.fatal!("Error: home directory #{home_directory} of user #{new_resource.username} does not exist")
        end
      end
    end
  end
  
  # manage authorized_keys
  if !authorized_keys.empty? then
    directory "#{home_directory}/.ssh" do
      owner new_resource.username
      group primary_group
      mode 0700
    end

    file "#{home_directory}/.ssh/authorized_keys" do
      action :create_if_missing
      owner new_resource.username
      group primary_group
      mode 0644
    end
    
    authorized_keys.each do |key|
      append_if_no_line "authrorized key #{key[0..10]} ..." do
        path "#{home_directory}/.ssh/authorized_keys"
        line key
      end
    end
  end

end
