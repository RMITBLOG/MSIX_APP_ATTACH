<#	
	.NOTES
	===========================================================================
	 
	 Created on:   	19/08/2020 23:38
	 Created by:   	Ryan Mangan
	 Organization: 	ryanmangans IT BLOG LTD
	 Filename:     	createvdisk.ps1
	===========================================================================
	.DESCRIPTION
		Create a virtual disk for MSIX App Attach
#>

# Create Vdisk for App Attach
write-Host "Ryan Mangans IT Blog Technical Demo" -ForegroundColor yellow
Write-Host "MSIX App Attach Disk creation" -ForegroundColor Green
$filepath = read-Host "Enter the file path and name for the VHD e.g c:\temp\notepad++.vhd"
#Create vdisk
New-VHD -SizeBytes 1024MB -Path $filepath -Dynamic -Confirm:$false
#mount vdisk
$vhdObject = Mount-VHD $filepath -Passthru
#Intialise the disk
$vdisk = Initialize-Disk -Passthru -Number $vhdObject.Number
# create a disk partition 
$partition = New-Partition -AssignDriveLetter -UseMaximumSize -DiskNumber $vdisk.Number
# Format-Volume -FileSystem NTFS -Confirm:$false -DriveLetter $partition.DriveLetter -Force
Format-Volume -FileSystem NTFS -Confirm:$false -DriveLetter $partition.DriveLetter -Force
