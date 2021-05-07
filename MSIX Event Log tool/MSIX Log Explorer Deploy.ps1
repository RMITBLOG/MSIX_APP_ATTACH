<#	
	.NOTES
	===========================================================================
	 Created on:   	07/05/2021 00:41
	 Created by:   	Ryan Mangan	
	 Organization: 	Ryan Mangans IT Blog
	 Filename:     	MSIX Log Explorer WVD Host Installation Script.
	===========================================================================
	.DESCRIPTION
		This script downloads MSIX Log Explorer from the RMITBLOG GIT Hub Repo and installed on the required WVD Session host.

		The Script has been designed to be used with Azure Script Extentions to automate the process of deploying the MSIX Log Explorer on session hosts.

		Any issues, please feedback through GitHUB.
#>


#Run app on user logon.

New-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Run -Name MSIXLOGEXPLORER -Value "C:\Program Files\Ryanmangansitblog ltd\MSIX Log Explorer\MSIX log Explorer.exe"


# Define where to store logs
[string]$temPAth = 'C:\temp\'

# Create folder if does not exist
if (!(Test-Path -Path $temPAth))
{
	$paramNewItem = @{
		Path	 = $temPAth
		ItemType = 'Directory'
		Force    = $true
	}
	
	New-Item @paramNewItem
}


#Download MSIX Log Explorer
invoke-WebRequest -Uri "https://github.com/RMITBLOG/MSIX_APP_ATTACH/blob/master/MSIX%20Event%20Log%20tool/MSIX%20Log%20Explorer.msi?raw=true" -OutFile "C:\temp\MSIXLOGEXPLORER.msi"
Start-Sleep -s 5


#Install MSIX Log Explorer
msiexec /i "C:\temp\MSIXLOGEXPLORER.msi" /q /n
Start-Sleep -s 2

Write-Host "Installation complete"
