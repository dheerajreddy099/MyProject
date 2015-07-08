# NTP defaults
default['CG-LNX-core_os']['ntp']['driftfile'] = '/var/lib/ntp/drift'
default['CG-LNX-core_os']['ntp']['keys'] = '/etc/ntp/keys'
# default['CG-LNX-core_os']['ntp']['servers'] = {
# 'snx1ntp2.capgroup.com'  => '10.30.2.245',
#  'phx1ntp2.capgroup.com'  => '10.92.6.136'
# }
# Default setup packages
default['CG-LNX-core_os']['setup']['add']['packages'] = [
  'ksh',
  'cups',
  'xterm',
  'autofs',
  'pam_ldap',
  'ftp',
  'rdist',
  'libXp',
  'openmotif22',
  'compat-glibc',
  'libXtst',
  'redhat-lsb',
  'enscript',
  'glibc-devel',
  'dos2unix',
  'perl-Time-HiRes',
  'gdb',
  'xorg-x11-xauth',
  'lsscsi'
]

default['CG-LNX-core_os']['setup']['add']['packages_i686'] = [
  'compat-libstdc++-33',
  'glibc',
  'glibc-devel',
  'pam'
]

default['CG-LNX-core_os']['setup']['remove']['packages'] = [
  'abrt',
  'abrt-libs',
  'abrt-addon-ccpp',
  'abrt-addon-kerneloops',
  'abrt-addon-python',
  'abrt-cli',
  'abrt-tui'
]

default['CG-LNX-core_os']['setup']['directory']['remove'] = [
  '/usr/local/games',
  '/var/games',
  '/usr/games',
  '/usr/share/games',
  '/usr/lib/games',
  '/usr/lib64/games',
  '/var/lib/games'
]

default['CG-LNX-core_os']['setup']['symlink'] = {
  '/bin/bash2' => '/bin/bash',
  '/usr/bin/bash' => '/bin/bash',
  '/usr/bin/ksh' => '/bin/ksh',
  '/usr/bin/sh' => '/bin/sh',
  '/usr/local/etc/sudoers' => '/etc/sudoers'
}

default['CG-LNX-core_os']['setup']['users']['default']['gid'] = 99
default['CG-LNX-core_os']['setup']['users']['default']['shell'] = '/bin/bash'
default['CG-LNX-core_os']['setup']['users']['default']['home'] = '/home'
default['CG-LNX-core_os']['setup']['users']['default']['skel'] = '/etc/skel'

# Netbackup settings
default['CG-LNX-core_os']['nbu']['home'] = '/usr/openv/netbackup'
default['CG-LNX-core_os']['nbu']['exclude'] = [
  '/tmp',
  '/users/oradata/*',
  '/users/oracle',
  '/users/cgoracle'
]

# Limits settings
default['CG-LNX-core_os']['limits']['conf']['*']['core']['soft'] = 'unlimited'
default['CG-LNX-core_os']['limits']['conf']['*']['core']['hard'] = 'unlimited'
default['CG-LNX-core_os']['limits']['conf']['*']['nofile']['soft'] = '16384'
default['CG-LNX-core_os']['limits']['conf']['*']['nofile']['hard'] = '65536'
default['CG-LNX-core_os']['limits']['conf']['oracle']['memlock']['soft'] = 'unlimited'
default['CG-LNX-core_os']['limits']['conf']['oracle']['memlock']['hard'] = 'unlimited'

default['CG-LNX-core_os']['limits']['90-nproc']['*']['nproc']['soft'] = '32768'
default['CG-LNX-core_os']['limits']['90-nproc']['root']['nproc']['soft'] = 'unlimited'

default['CG-LNX-core_os']['etc']['prelink'] = 'no'

# shells
default['CG-LNX-core_os']['etc']['shells'] = [
  '/bin/sh',
  '/bin/bash',
  '/sbin/nologin',
  '/bin/ksh',
  '/bin/tcsh',
  '/bin/csh',
  '/usr/bin/ksh',
  '/bin/dash',
  '/bin/centrifyda',
  '/usr/bin/dzsh'
]

# securetty
default['CG-LNX-core_os']['etc']['securetty'] = [
  'console',
  'vc/1',
  'vc/2',
  'vc/3',
  'vc/4',
  'vc/5',
  'vc/6',
  'vc/7',
  'vc/8',
  'vc/9',
  'vc/10',
  'vc/11',
  'tty1',
  'tty2',
  'tty3',
  'tty4',
  'tty5',
  'tty6',
  'tty7',
  'tty8',
  'tty9',
  'tty10',
  'tty11',
  'ttyS1',
  'ttyS0'
]

# Aliases
default['CG-LNX-core_os']['etc']['aliases'] = {
  'root'      => 'unix@ioadmprod-v1',
  'sybase'    => 'db-admin@capgroup.com',
  'oracle'    => 'db-admin@capgroup.com',
  'msm'       => 'msm@capgroup.com',
  'patrol'    => 'db-admin@capgroup.com',
  'quest'     => 'db-admin@capgroup.com',
  'epage'     => 'unix@ioadmprod-v1',
  'jiladm'    => 'prodcntl@capgroup.com',
  'dazel'     => 'dazelhelp@capgroup.com',
  'jobob2'    => 'unix@ioadmprod-v1',
  'oradv1'    => 'db-admin@capgroup.com',
  'oradps1'   => 'db-admin@capgroup.com',
  'oradtmp'   => 'db-admin@capgroup.com',
  'oratr1'    => 'db-admin@capgroup.com',
  'oracon'    => 'db-admin@capgroup.com',
  'oradev'    => 'db-admin@capgroup.com',
  'oratrn'    => 'db-admin@capgroup.com',
  'oraprd'    => 'db-admin@capgroup.com',
  'autosys'   => 'prodcntl@capgroup.com',
  'jobutl'    => 'prodcntl@capgroup.com',
  'jobdba'    => 'db-admin@capgroup.com',
  'shutdown'  => 'unix@ioadmprod-v1',
  'secureid'  => 'unix@ioadmprod-v1',
  'lp'        => 'unix@ioadmprod-v1',
  'oratmp'    => 'db-admin@capgroup.com',
  'jobora'    => 'db-admin@capgroup.com'
}

default['CG-LNX-core_os']['cron']['users']['allow'] = %w(root adm uucp sybase oracle)

# default['CG-LNX-core_os']['satellite']['server'] = 'x007023.cgftdev.com'

# Now in environments instead of cookbook
# Yum Repos, just add more blocks for additional repos
# default['CG-LNX-core_os']['yumrepos']['cg-rhel'] = {
#     "name" => "rhel",
#      "baseurl" => "ttp://172.17.0.27/yumrepos/rhel66/",
#      "enabled" => "1",
#      "gpgcheck" => "no",
#      "gpgkey" => "a"
# }

# default['CG-LNX-core_os']['yumrepos']['test'] = {
#      "name" => "test",
#      "baseurl" => "ttp://172.17.0.27/yumrepos/test/",
#      "enabled" => "1",
#      "gpgcheck" => "no",
#      "gpgkey" => "a"
# }

# default["CG-LNX-core_os"]["resolv"]["nameservers"] = ["127.0.0.1", "127.0.0.2"]
