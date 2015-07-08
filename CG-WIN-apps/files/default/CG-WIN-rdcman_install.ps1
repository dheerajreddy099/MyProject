[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string]$title,

    [Parameter(Mandatory=$False)]
    [string]$version,

    [Parameter(Mandatory=$False)]
    [string]$setup_folder,

    [Parameter(Mandatory=$False)]
    [string]$setup_path = "c:\CG\Setup",

    [Parameter(Mandatory=$False)]
    [string]$log_path = "c:\CG\Logs"
)

# This script log file
$script_log = ("$log_path\$title script.log")

# Write to file values of script arguments to debug_log
$DateTime = Get-Date -format "MM/dd/yyyy HH:mm:ss"

"Run Install:  $DateTime"          | Set-Content $script_log
"`r`nPARAMETERS"                   | Add-Content $script_log
"Software Title:    $title"        | Add-Content $script_log
"Software Version:  $version"      | Add-Content $script_log
"Setup Path:        $setup_path"   | Add-Content $script_log
"Setup Folder:      $setup_folder" | Add-Content $script_log

# Installer log file
$install_log = ("$log_path\$title install.log").Replace(" ", "_")

# Installer
# $installer = "Setup.exe"  # Setup.exe type installers
$installer = "RDCMan.msi"   # Install.msi typs installers

# Installer parameters, use only one of the following
# $AllArgs = @("/s", "/v/qn /l `"$install_log`"")                                   # Setup.exe type installers
$AllArgs = @("/i $setup_path\$setup_folder\$installer", "/l $install_log", "/qn")  # Install.msi typs installers

# Installer parameters
"`r`nInstaller Parameters"     | Add-Content $script_log
"Installer Log:  $install_log" | Add-Content $script_log
$AllArgs                       | Add-Content $script_log

# Execute install, use only one of the following
# & "$setup_path\$setup_folder\$installer" $AllArgs         # Setup.exe type installers
Start-Process "msiexec.exe" -ArgumentList $AllArgs -Wait  # Install.msi typs installers

$RC = $LASTEXITCODE 
If ($RC) {
    "`r`nInstall Failed" | Add-Content $script_log
    "Return Code = $rc"  | Add-Content $script_log
}

# Custom post install code
