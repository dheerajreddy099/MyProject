###########################################################################
#
#   This PowerShell script install Office 2010 with a Configuration and Admin file
#
############################################################################

############################################################################

#  Prerequisite: Office Source files, config.xml, and admin.msp in c:\CG\Setup on local host

#  Author: JALS
#  Date:   03/11/2015

# HEADER ###################################################################

# Import-Module If Needed
$DateTime = Get-Date -format "MM/dd/yyyy HH:mm:ss"
$DateTimeFile = Get-Date -format "MMddyyyy_HHmmss"
$Date = Get-Date -UFormat %m%Y
#$Log = "c:\cg\logs\file_name.txt"
#$csvout = "c:\cg\logs\file_name.csv"


# VARIABLE #################################################################

$Source_path   = "c:\cg\setup\Office2010Source"
$Office_Setup  = $Source_path + "\setup.exe"
$Office_Config = $Source_path + "\MS-Office_Setup_Config-AdminE.xml"
$Office_Admin  = $Source_path + "\Office2010_Excel_Word.msp"
$LogOutput     = "c:\cg\logs\office_intall.log"

# MAIN ######################################################################

# write-host "InstallOffice2010_Word_Excel"
# Invoke-expression "& '$Office_Setup' /config $Office_Config /adminfile $Office_Admin"
& $Office_Setup /config $Office_Config /adminfile $Office_Admin

$RC = $LASTEXITCODE 
If ($RC) 
{
("Office setup failed, return code=$rc")  > $LogOutput
}

