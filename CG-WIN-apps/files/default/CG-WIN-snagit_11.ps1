Configuration Snagit_11
{
    # Import-DscResource -Name MSFT_xRemoteFile -ModuleName xPSDesiredStateConfiguration
    Import-DscResource -Module xPSDesiredStateConfiguration

    Node ("localhost")
    {
        # xRemoteFile Install_Archive
        # {
        #     DestinationPath = "c:\chef\cache"
        #     URI = "http://x007019.cgftdev.com/pkgdist/windows/agents/TechSmith_SnagIt_11.0.1.zip"
        # }

        # Archive Install_Files
        # {
        #     Ensure = "Present"
        #     Destination = "C:\CG\Setup"
        #     Path = "C:\chef\cache\TechSmith_SnagIt_11.0.1.zip"
        #     # DependsOn = "[xRemoteFile]Install_Archive"
        # }

        # xPackage SnagIt
        # {
        #     Name = "Snagit 11"
        #     Path = "C:\CG\Setup\TechSmith SnagIt 11.0.1\SnagIt_11_0_1.msi"
        #     ProductID = "" 
        #     # "F8E3C768-71F3-11E1-9DF7-70804824019B"
        #     Arguments = "TRANSFORMS=`"C:\CG\Setup\TechSmith SnagIt 11.0.1\\SnagIt_11_0_1.mst`" /qn"
        #     Ensure = 'Present'
        #     LogPath = "c:\CG\Logs\snagit_install.log"
        #     DependsOn = "[Archive]Install_Files"
        # }

        # Script SnagIt_Install
        # {
        #     GetScript = 
        #     {
        #         $UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

        #         $InstalledSoftware = @{}

        #         ForEach($Software in $UnInstallSoftware)
        #         {
        #             If (!$Software.DisplayName -or !$Software.DisplayVersion)
        #             { }
        #             Else
        #             {
        #                 $InstalledSoftware.Add($Software.DisplayName , $Software.DisplayVersion)
        #             }
        #         }
        #         Return $InstalledSoftware
        #     }
        #     SetScript =
        #     {
        #         cd 'C:\CG\Setup\TechSmith SnagIt 11.0.1'
        #         # msiexec /i SnagIt_11_0_1.msi /l c:\CG\Logs\snagit.log /qn
        #         msiexec /i SnagIt_11_0_1.msi TRANSFORMS=SnagIt_11_0_1.mst /l c:\CG\Logs\snagit.log /qn
        #     }
        #     TestScript =
        #     {
        #         $UnInstallSoftware = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*

        #         $InstalledSoftware = @{}

        #         $SnagIt = $false

        #         ForEach($Software in $UnInstallSoftware)
        #         {
        #             If ($Software.DisplayName -eq "SnagIt 11")
        #             {
        #                 $SnagIt = $true
        #             }
        #         }
        #         Return $SnagIt
        #     }
        # }

        # File ImageQuickStyles
        # {
        #     Ensure = "Present"
        #     SourcePath = "C:\CG\Setup\TechSmith SnagIt 11.0.1\ImageQuickStyles.xml"
        #     DestinationPath = "%ProgramData%\TechSmith\Snagit 11"
        #     DependsOn = "[Script]SnagIt_Install"
        #     Checksum = "SHA-1"
        #     Force = $true
        # }

        # File SnagIt900
        # {
        #     Ensure = "Present"
        #     SourcePath = "C:\CG\Setup\TechSmith SnagIt 11.0.1\SnagIt900.sdf"
        #     DestinationPath = "%ProgramData%\TechSmith\Snagit 11\SnagIt900.sdf"
        #     Force = $true
        #     # DependsOn = "[Script]SnagIt_Install"
        # }

        # File DrawQuickStyles
        # {
        #     Ensure = "Present"
        #     SourcePath = "C:\CG\Setup\TechSmith SnagIt 11.0.1\DrawQuickStyles.xml"
        #     DestinationPath = "%ProgramData%\TechSmith\Snagit 11\DrawQuickStyles.xml"
        #     # DependsOn = "[Script]SnagIt_Install"
        # }

        # File Tray
        # {
        #     Ensure = "Present"
        #     Type = "File"
        #     SourcePath = "C:\CG\Setup\TechSmith SnagIt 11.0.1\Tray.bin"
        #     DestinationPath = "%ProgramData%\TechSmith\Snagit 11\Tray.bin"
        #     Force = $true
        #     # DependsOn = "[Script]SnagIt_Install"
        # }

        # File customization
        # {
        #     Ensure = "Present"
        #     Type = "File"
        #     SourcePath = "C:\CG\Setup\TechSmith SnagIt 11.0.1\customization.reg"
        #     DestinationPath = "%ProgramData%\TechSmith\Snagit 11\customization.reg"
        #     Force = $true
        #     # DependsOn = "[Script]SnagIt_Install"
        # }

        # File exeregistries
        # {
        #     Ensure = "Present"
        #     Type = "File"
        #     SourcePath = "C:\CG\Setup\TechSmith SnagIt 11.0.1\exeregistries.reg"
        #     DestinationPath = "%ProgramData%\TechSmith\Snagit 11\exeregistries.reg"
        #     Force = $true
        #     # DependsOn = "[Script]SnagIt_Install"
        # }

        # File activesetup
        # {
        #     Ensure = "Present"
        #     Type = "File"
        #     SourcePath = "C:\CG\Setup\TechSmith SnagIt 11.0.1\activesetup.cmd"
        #     DestinationPath = "%ProgramData%\TechSmith\Snagit 11\activesetup.cmd"
        #     Force = $true
        #     # DependsOn = "[Script]SnagIt_Install"
        # }

        Registry License_Key
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\TechSmith\SnagIt\11"
            ValueName = "RegistrationKey"
            ValueData = "MMFWC-UYSC7-MA5WS-Q9AQM-Q55C6"
            ValueType = "String"
           # DependsOn = "[Script]SnagIt_Install"
        }

        Registry Licensed_User
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\TechSmith\SnagIt\11"
            ValueName = "RegisteredTo"
            ValueData = "CGC User"
            ValueType = "String"
          #  DependsOn = "[Script]SnagIt_Install"
        }

        Registry TechSmith
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{F8E3C768-71F3-11E1-9DF7-70804824019B}"
            ValueName = ""
            ValueData = "TechSmith SnagIt 11"
            ValueType = "String"
         #   DependsOn = "[Script]SnagIt_Install"
        }

        Registry Version
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{F8E3C768-71F3-11E1-9DF7-70804824019B}"
            ValueName = "Version"
            ValueData = "11"
            ValueType = "String"
         #   DependsOn = "[Script]SnagIt_Install"
        }

        Registry StubPath
        {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{F8E3C768-71F3-11E1-9DF7-70804824019B}"
            ValueName = "StubPath"
            ValueData = "`"%ProgramData%\TechSmith\Snagit 11\activesetup.cmd`""
            ValueType = "ExpandString"
         #   DependsOn = "[Script]SnagIt_Install"
        }
    }
}
