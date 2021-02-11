<#	
	.NOTES
	===========================================================================
	 Created on:   	10/02/2021 19:07
	 Created by:   	Ryan Mangan
	 Organization: 	Ryanmangansitblog ltd
	 Filename:     	list-cims.ps1
	===========================================================================
	.DESCRIPTION
		script to list only CIMFS mounted images
#>


Get-ciminstance -classname win32_volume | where filesystem -EQ 'cimfs' | select name, filesystem, DeviceID




