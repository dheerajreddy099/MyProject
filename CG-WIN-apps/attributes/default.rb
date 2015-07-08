# PowerShell DSC script deployment and execution path
default['CG-WIN-apps']['dsc_script_path'] = 'c:\CG\Setup'
default['CG-WIN-apps']['ps_script_path']  = 'c:\CG\PowerShell'

# short-circuit the remote pkg source in cookbook attribute
# (it will be set at environment level)
default['CG']['artifact_server'] = '127.0.0.1'

# ========= #
#  SnagIt   #
# ========= #

# PowerShell script deployment and execution path
default['CG-WIN-apps']['SnagIt']['script_folder']    = 'c:\CG\Setup'
default['CG-WIN-apps']['SnagIt']['logs_folder']      = 'c:\CG\Logs'
default['CG-WIN-apps']['SnagIt']['setup_folder']     = 'c:\CG\Setup'

# DSC config
default['CG-WIN-apps']['SnagIt']['dsc_script']       = 'CG-WIN-snagit_11.ps1'
default['CG-WIN-apps']['SnagIt']['dsc_config']       = 'Snagit_11'

# Application Installation
default['CG-WIN-apps']['SnagIt']['install_script']   = 'CG-WIN-snagit_11_install.ps1'
default['CG-WIN-apps']['SnagIt']['guard_script']     = 'Get-InstalledSoftware.ps1'

# Software details
default['CG-WIN-apps']['SnagIt']['software_title']   = 'SnagIt 11'
default['CG-WIN-apps']['SnagIt']['software_version'] = '11.0.1'
default['CG-WIN-apps']['SnagIt']['installer_folder'] = 'TechSmith SnagIt 11.0.1'

# Archive details
default['CG-WIN-apps']['SnagIt']['archive_folder']   = 'pkgdist/windows/apps'
default['CG-WIN-apps']['SnagIt']['archive_file']     = 'TechSmith_SnagIt_11.0.1.zip'
default['CG-WIN-apps']['SnagIt']['archive_checksum'] = 'c5abedfcc3a3904836e6c0549c67848c2cb32a66e7fa712daa713c1cc82e20e8'

# =============== #
#   RDC Manager   #
# =============== #

# PowerShell script deployment and execution path
default['CG-WIN-apps']['RDCMan']['script_folder']    = 'c:\CG\Setup'
default['CG-WIN-apps']['RDCMan']['logs_folder']      = 'c:\CG\Logs'
default['CG-WIN-apps']['RDCMan']['setup_folder']     = 'c:\CG\Setup'

# DSC configuration
default['CG-WIN-apps']['RDCMan']['dsc_script']       = 'CG-WIN-rdcman.ps1'
default['CG-WIN-apps']['RDCMan']['dsc_config']       = 'RDCMan'

# Application Installation
default['CG-WIN-apps']['RDCMan']['install_script']   = 'CG-WIN-rdcman_install.ps1'
default['CG-WIN-apps']['RDCMan']['guard_script']     = 'Get-InstalledSoftware.ps1'

# Software details
default['CG-WIN-apps']['RDCMan']['software_title']   = 'Remote Desktop Connection Manager'
default['CG-WIN-apps']['RDCMan']['software_version'] = '2.7.14060'
default['CG-WIN-apps']['RDCMan']['installer_folder'] = 'RDCMan'

# Archive details
default['CG-WIN-apps']['RDCMan']['archive_folder']   = 'pkgdist/windows/server_tools'
default['CG-WIN-apps']['RDCMan']['archive_file']     = 'RDCMan.zip'
default['CG-WIN-apps']['RDCMan']['archive_checksum'] = '835400a4739f49ce82e67ca7aaf81afc9d8982e0dd7200a37683129ca9d5a47b'

# =============== #
#   Firefox v37   #
# =============== #

# PowerShell script deployment and execution path
default['CG-WIN-apps']['firefox_37']['script_folder']    = 'c:\CG\Setup'
default['CG-WIN-apps']['firefox_37']['logs_folder']      = 'c:\CG\Logs'
default['CG-WIN-apps']['firefox_37']['setup_folder']     = 'c:\CG\Setup'

# Application Installation
default['CG-WIN-apps']['firefox_37']['guard_script']     = 'Get-InstalledSoftware.ps1'

# Software details
default['CG-WIN-apps']['firefox_37']['software_title']   = 'Mozilla firefox'
default['CG-WIN-apps']['firefox_37']['software_version'] = '37'
default['CG-WIN-apps']['firefox_37']['installer_folder'] = 'firefox'

# Archive details
default['CG-WIN-apps']['firefox_37']['archive_folder']   = 'pkgdist/windows/server_tools'
default['CG-WIN-apps']['firefox_37']['archive_file']     = 'firefox.zip'
default['CG-WIN-apps']['firefox_37']['archive_checksum'] = '835400a4739f49ce82e67ca7aaf81afc9d8982e0dd7200a37683129ca9d5a47b' #must change checksum to appropriate value



# =============== #
#   Notedap++ 6.5   #
# =============== #

# PowerShell script deployment and execution path
default['CG-WIN-apps']['notepad_plus_6.5']['script_folder']    = 'c:\CG\Setup'
default['CG-WIN-apps']['notepad_plus_6.5']['logs_folder']      = 'c:\CG\Logs'
default['CG-WIN-apps']['notepad_plus_6.5']['setup_folder']     = 'c:\CG\Setup'

# Application Installation
default['CG-WIN-apps']['notepad_plus_6.5']['guard_script']     = 'Get-InstalledSoftware.ps1'

# Software details
default['CG-WIN-apps']['notepad_plus_6.5']['software_title']   = 'Notepad plus'
default['CG-WIN-apps']['notepad_plus_6.5']['software_version'] = '6.5'
default['CG-WIN-apps']['notepad_plus_6.5']['installer_folder'] = 'notepad'

# Archive details
default['CG-WIN-apps']['notepad_plus_6.5']['archive_folder']   = 'pkgdist/windows/server_tools'
default['CG-WIN-apps']['notepad_plus_6.5']['archive_file']     = 'notepad.zip'
default['CG-WIN-apps']['notepad_plus_6.5']['archive_checksum'] = '835400a4739f49ce82e67ca7aaf81afc9d8982e0dd7200a37683129ca9d5a47b' #must change checksum to appropriate value



# =============== #
#  Adobe Reader  #
# =============== #

# PowerShell script deployment and execution path
default['CG-WIN-apps']['adobe_reader_11.0.10']['script_folder']    = 'c:\CG\Setup'
default['CG-WIN-apps']['adobe_reader_11.0.10']['logs_folder']      = 'c:\CG\Logs'
default['CG-WIN-apps']['adobe_reader_11.0.10']['setup_folder']     = 'c:\CG\Setup'

# Application Installation
default['CG-WIN-apps']['adobe_reader_11.0.10']['guard_script']     = 'Get-InstalledSoftware.ps1'

# Software details
default['CG-WIN-apps']['adobe_reader_11.0.10']['software_title']   = 'Mozilla firefox'
default['CG-WIN-apps']['adobe_reader_11.0.10']['software_version'] = '37'
default['CG-WIN-apps']['adobe_reader_11.0.10']['installer_folder'] = 'firefox'

# Archive details
default['CG-WIN-apps']['adobe_reader_11.0.10']['archive_folder']   = 'pkgdist/windows/server_tools'
default['CG-WIN-apps']['adobe_reader_11.0.10']['archive_file']     = 'adobe_reader.zip'
default['CG-WIN-apps']['adobe_reader_11.0.10']['archive_checksum'] = '835400a4739f49ce82e67ca7aaf81afc9d8982e0dd7200a37683129ca9d5a47b' #must change checksum to appropriate value
