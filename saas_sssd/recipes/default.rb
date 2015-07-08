#
# Cookbook Name:: saas_sssd
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "msktutil" do
  version "0.5.1"
end

%w{ krb5 krb5-32bit krb5-client }.each do |pkg|
  package pkg
end

%w{ sssd libsss_sudo }.each do |pkg|
  package pkg do
    version "1.9.5"
  end
end

template '/etc/krb5.conf' do
  source 'krb5.conf.erb'
  variables(
      :domain => node[:saas_sssd][:domain],
      :server => node[:saas_sssd][:server].split(',')[0]
  )
end

template '/etc/sssd/sssd.conf' do
  source 'sssd.conf.erb'
  variables(
      :domain => node[:saas_sssd][:domain],
      :server => node[:saas_sssd][:server],
      :ldap_bind_user => node[:saas_sssd][:ldapBindUser],
      :ldap_bind_password => SaaSCrypt.decrypt(node[:saas_sssd][:ldapBindPassword]),
      :ldap_access_filter => node[:saas_sssd][:ldapAccessFilter],
      :ldapType => node[:saas_sssd][:ldapType],
      :fallbackHomeDir => node[:saas_sssd][:sssdConf][:fallbackHomeDir],
      :defaultShell => node[:saas_sssd][:sssdConf][:defaultShell],
      :entryCacheTimeout => node[:saas_sssd][:sssdConf][:entryCacheTimeout]
  )
  mode 0600
  notifies :reload, 'service[sssd]'
end

%w{ passwd group sudoers}.each do |conf|
  replace_or_add "nsswitch.conf #{conf}" do
    path "/etc/nsswitch.conf"
    pattern "#{conf}:.*"
    line "#{conf}: files sss"
  end
end

%w{ common-account-pc	common-auth-pc		common-password-pc	common-session-pc }.each do |conf|
  cookbook_file conf do
    path "/etc/pam.d/#{conf}"
  end
end

%w{ passwd group services}.each do |conf|
  replace_or_add "nscd.conf #{conf}" do
    path "/etc/nscd.conf"
    pattern "enable-cache.*#{conf}.*yes"
    line "        enable-cache            #{conf}           no"
    notifies :restart, "service[nscd]", :immediately
  end
end

service "nscd" do
   action :nothing
end

bash "joindomain" do
  code <<-EOH
    echo '#{SaaSCrypt.decrypt(node[:saas_sssd][:ldapJoinPassword])}' | kinit #{node[:saas_sssd][:ldapJoinUser]}  
    msktutil -c -b #{node[:saas_sssd][:ldapComputerOU]} --server #{node[:saas_sssd][:server].split(',')[0]} --service host --upn HOST/#{node[:fqdn]} --computer-name #{node[:hostname]} -N -h #{node[:fqdn]}    
  EOH
  not_if "kinit -kt /etc/krb5.keytab host/#{node[:fqdn]}@#{node[:saas_sssd][:domain].upcase}"  
end


service "sssd" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

cron_d 'msktutil-auto-update' do
  minute  0
  hour    23
  command "msktutil --auto-update --service host --upn HOST/#{node[:fqdn]} --computer-name #{node[:hostname]} -h #{node[:fqdn]}"
  user    'root'
end

cookbook_file 'sssd-clear-cache.sh' do
    path "/usr/sbin/sssd-clear-cache.sh"
    mode '0755'
end


#temp for now until sudo via AD is working
file "/etc/sudoers.d/sudo_root_for_all" do
  content "ALL ALL=(ALL) NOPASSWD:ALL"
  owner 'root'
  group 'root'
  mode '440'
end