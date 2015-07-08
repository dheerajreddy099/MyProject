####################################################################################
# unixodbc
####################################################################################
default['saas_zabbix']['unixodbc']['odbcIniSource'] = nil
default['saas_zabbix']['unixodbc']['odbcIniDestination'] = '/etc/unixODBC/odbc.ini'

default['saas_zabbix']['unixodbc']['odbcinstIniSource'] = 'odbcinst.ini.erb'
default['saas_zabbix']['unixodbc']['odbcinstIniDestination'] = '/etc/unixODBC/odbcinst.ini'
default['saas_zabbix']['unixodbc']['odbcinstIni']['oracleDriver'] = '/usr/local/etc/instantclient_11_2/libsqora.so.11.1'
default['saas_zabbix']['unixodbc']['odbcinstIni']['mssqlDriver'] = '/usr/local/etc/microsoft_odbc/sqlncli/lib64/libsqlncli-11.0.so.1790.0'

default['saas_zabbix']['unixodbc']['tnsnamesOraSource'] = nil
default['saas_zabbix']['unixodbc']['tnsnamesOraDestination'] = '/usr/local/etc/instantclient_11_2/network/admin/tnsnames.ora'

default['saas_zabbix']['unixodbc']['packageName'] = 'zabbix-oracle-instantclient'
default['saas_zabbix']['unixodbc']['version'] = '11.2-1.0'
default['saas_zabbix']['unixodbc']['requiredPackages']   = {'unixODBC-devel' => nil}

####################################################################################
# microsoft odbc
####################################################################################

default['saas_zabbix']['microsoftodbc']['packageName'] = 'zabbix-microsoft-odbc'
default['saas_zabbix']['microsoftodbc']['version'] = '11.0.1790.0-1.0'
default['saas_zabbix']['microsoftodbc']['packageSource'] = "#{node["saas"]["repo"]["main"]}/common/yum/SLES/11.3/zabbix/zabbix-microsoft-odbc-11.0.1790.0-1.0.x86_64.rpm"

####################################################################################
# snmp
####################################################################################

default['saas_zabbix']['snmp']['packageName'] = 'zabbix-snmp'
default['saas_zabbix']['snmp']['version'] = '1.0-1.0'
default['saas_zabbix']['snmp']['requiredPackages']   = {'net-snmp' => nil}
default['saas_zabbix']['snmp']['serviceName'] = 'snmpd'
default['saas_zabbix']['snmp']['configDir'] = node['sap-zabbix']['configDir'] + '/snmp'
default['saas_zabbix']['snmp']['config'] = '/etc/snmp/snmp.conf'
default['saas_zabbix']['snmp']['configTemplate'] = 'snmp.conf.erb'
default['saas_zabbix']['snmp']['configDirList'] = [ node['saas_zabbix']['snmp']['configDir'], "#{node['saas_zabbix']['snmp']['configDir']}/mibs", "#{node['saas_zabbix']['snmp']['configDir']}/mibs/cisco", "#{node['saas_zabbix']['snmp']['configDir']}/mibs/vsp" ]
