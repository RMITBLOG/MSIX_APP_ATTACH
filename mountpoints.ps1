<#	
	.NOTES
	===========================================================================
	  Created on:   10/02/2021 18:19
	 Created by:   	Ryan Mangan	
	 Organization: 	Ryanmangansitblog ltd
	 Website: https;//ryanmangansitblog.com
	 Filename:     	mountpoints.ps1
	===========================================================================
	.DESCRIPTION
		This script lists all mountpoints on the OS. This helps you identify the difference between local disks, Virtual Disks and CIMFS.
#>

$TotalGB = @{ Name = "Capacity(GB)"; expression = { [math]::round(($_.Capacity/ 1073741824), 2) } }
$FreeGB = @{ Name = "FreeSpace(GB)"; expression = { [math]::round(($_.FreeSpace / 1073741824), 2) } }
$FreePerc = @{ Name = "Free(%)"; expression = { [math]::round(((($_.FreeSpace / 1073741824)/($_.Capacity / 1073741824)) * 100), 0) } }

function get-mountpoints
{
	$volumes = Get-WmiObject win32_volume -Filter "DriveType='3'"
	$volumes | Select Name, Label, FileSystem | Format-Table -AutoSize
}

get-mountpoints

