name             'CG-WIN-apps'
maintainer       'Capital Group'
maintainer_email 'arxc@capgroup.com'
license          'All rights reserved'
description      'Installs/Configures CG-WIN-apps'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

# both required for windows_zipfile
depends 'windows'
depends 'CG-ALL-chefgems'

# required for PowerShell helper functions
#depends 'CG-WIN-ps_modules'
