Configuration Excel_2010
{
    node("localhost")
    {
        Script Excel_Install
        {
            GetScript = 
            {
                $UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

                $InstalledSoftware = @{}

                ForEach($Software in $UnInstallSoftware)
                {
                    If (!$Software.DisplayName -or !$Software.DisplayVersion)
                    { }
                    Else
                    {
                        $InstalledSoftware.Add($Software.DisplayName , $Software.DisplayVersion)
                    }
                }
                Return $InstalledSoftware
            }
            SetScript =
            {
                $ProcessActive = Get-Process setup -ErrorAction SilentlyContinue

                If ($ProcessActive -eq $null)
                {
                    cd 'C:\CG\Setup\Excel 2010'
                    .\setup.exe /adminfile CG_Excel_custom_V1.msp
                }                

                $SleepCycle = 0
                Do
                {
                    $ProcessActive = Get-Process setup -ErrorAction SilentlyContinue
                    If ($ProcessActive)
                    {
                        Start-Sleep 60
                        $SleepCycle = $SleepCycle + 1
                    }
                } While ($ProcessActive -and $SleepCycle -lt 10)
            }
            TestScript =
            {
                $UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

                $InstalledSoftware = @{}

                $Excel = $false

                ForEach($Software in $UnInstallSoftware)
                {
                    If ($Software.DisplayName -eq "Microsoft Excel 2010")
                    {
                        $Excel = $true
                    }
                }
                Return $Excel
            }
        }
    }
}

Configuration Word_2010
{
    node("localhost")
    {

        Script Word_Install
        {
            GetScript = 
            {
                $UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

                $InstalledSoftware = @{}

                ForEach($Software in $UnInstallSoftware)
                {
                    If (!$Software.DisplayName -or !$Software.DisplayVersion)
                    { }
                    Else
                    {
                        $InstalledSoftware.Add($Software.DisplayName , $Software.DisplayVersion)
                    }
                }
                Return $InstalledSoftware
            }
            SetScript =
            {
                $ProcessActive = Get-Process setup -ErrorAction SilentlyContinue

                If ($ProcessActive -eq $null)
                {
                    cd 'C:\CG\setup\Word 2010'
                    .\setup.exe /adminfile CG_Word_custom_V1.msp
                }                

                $SleepCycle = 0
                Do
                {
                    $ProcessActive = Get-Process setup -ErrorAction SilentlyContinue
                    If ($ProcessActive)
                    {
                        Start-Sleep 60
                        $SleepCycle = $SleepCycle + 1
                    }
                } While ($ProcessActive -and $SleepCycle -lt 10)
            }
            TestScript =
            {
                $UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

                $InstalledSoftware = @{}

                $Word = $false

                ForEach($Software in $UnInstallSoftware)
                {
                    If ($Software.DisplayName -eq "Microsoft Word 2010")
                    {
                        $Word = $true
                    }
                }
                Return $Word
            }
        }
    }
}

Configuration Office_2010
{
    node("localhost")
    {
        Script Office_Install
        {
            GetScript = 
            {
                $UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

                $InstalledSoftware = @{}

                ForEach($Software in $UnInstallSoftware)
                {
                    If (!$Software.DisplayName -or !$Software.DisplayVersion)
                    { }
                    Else
                    {
                        $InstalledSoftware.Add($Software.DisplayName , $Software.DisplayVersion)
                    }
                }
                Return $InstalledSoftware
            }
            SetScript =
            {
                $ProcessActive = Get-Process setup -ErrorAction SilentlyContinue

                If ($ProcessActive -eq $null)
                {
                    cd 'C:\CG\Setup\Office2010Source'
                    .\setup.exe /config MS-Office_Setup_Config-AdminE.xml /adminfile Office2010_Excel_Word.msp
                }                

                $SleepCycle = 0
                Do
                {
                    $ProcessActive = Get-Process setup -ErrorAction SilentlyContinue
                    If ($ProcessActive)
                    {
                        Start-Sleep 60
                        $SleepCycle = $SleepCycle + 1
                    }
                } While ($ProcessActive -and $SleepCycle -lt 10)
            }
            TestScript =
            {
                $UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

                $InstalledSoftware = @{}

                $Office = $false

                ForEach($Software in $UnInstallSoftware)
                {
                    If ($Software.DisplayName -eq "Office 2010")
                    {
                        $Office = $true
                    }
                }
                Return $Office
            }
        }
    }
}