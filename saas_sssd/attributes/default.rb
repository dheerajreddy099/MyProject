#
# Cookbook Name:: saas_sssd
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

default[:saas_sssd][:domain]="SAAS-AD.SAP.CORP"
default[:saas_sssd][:server]="mo-c4eaa033f.saas-ad.sap.corp"
default[:saas_sssd][:ldapJoinUser]="joindom"
default[:saas_sssd][:ldapJoinPassword]="Start123!"
default[:saas_sssd][:ldapComputerOU]="ou=sapcloud"
default[:saas_sssd][:ldapType]="ldaps"

default[:saas_sssd][:sssdConf][:fallbackHomeDir]='/home/%u'
default[:saas_sssd][:sssdConf][:defaultShell]='/bin/bash'
#set default cache to expire after 1 hour
default[:saas_sssd][:sssdConf][:entryCacheTimeout]='3600'