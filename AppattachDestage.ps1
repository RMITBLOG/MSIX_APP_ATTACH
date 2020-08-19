<#	
	.NOTES
	===========================================================================
	 Created on:   	19/08/2020 20:31
	 Created by:   	Ryan Mangan
	 Organization: 	Ryan Mangans IT Blog ltd
	 website: 	https://ryanmangansitblog.com
	 Filename:     	AppattachDestage.ps1
	===========================================================================
	.DESCRIPTION
		MSIX App Attach Destage Script

		This script reads the Json Configuration file, and
		Destage's the Application and MSIX Junction from the host. 
		
		Point to note, ensure the VHD and json are in the same location as the script for this to work correctly.


		Its recommended that all scripts are signed to remove the need to elivate or change the remote execution policy on the host this script is being run.
#>


$configFPath = (Get-ChildItem $PSScriptloc -Filter *.json | Select-Object -First 1).FullName;
if ($null -eq $configFPath)
{
	throw "Missing config file Json!";
}

$configFile = Get-Content $configFPath -Raw | ConvertFrom-Json;

foreach ($package in $configFile)
{
	$vhdSrc = Join-Path $PSScriptloc $package.vhdFileName;
	$packageName = $package.packageName;
	$msixJunction = Join-Path $package.msixJunction $packageName;
	
	Remove-AppxPackage -AllUsers -Package $packageName;
	Dismount-DiskImage -ImagePath $vhdSrc;
	
	if (Test-Path $msixJunction)
	{
		Remove-Item $msixJunction -Force -Recurse;
	}
}


