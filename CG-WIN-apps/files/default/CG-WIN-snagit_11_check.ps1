$UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

$InstalledSoftware = @{}

$SnagIt = $false

ForEach($Software in $UnInstallSoftware)
{
    If ($Software.DisplayName -eq "SnagIt 11")
    {
        $SnagIt = $true
    }
}
Return $SnagIt
