$UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

$InstalledSoftware = @{}
$Excel = $false
$Word  = $false

ForEach($Software in $UnInstallSoftware)
{
    If ($Software.DisplayName -eq "Microsoft Office Excel MUI (English) 2010")
    {
        $Excel = $true
    }
    If ($Software.DisplayName -eq "Microsoft Office Word MUI (English) 2010")
    {
        $Word = $true
    }
}

If ($Excel -and $Word)
{
    Return $true
}
Else
{
    Return $false
}
