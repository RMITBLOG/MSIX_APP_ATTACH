<#	
	.NOTES
	===========================================================================
	 Created on:   	19/08/2020 20:31
	 Created by:   	Ryan Mangan
	 Organization: 	Ryan Mangans IT Blog ltd
   Webiste:       https://ryanmangansitblog.com
	 Filename:     	AppattachStage.ps1
	===========================================================================
	.DESCRIPTION
		MSIX App Attach Staging Script

		This script reads the Json Configuration file, mounts the VHD with no Drive letter and as read only.
		A new MSIX Junction is created with the package name
		Package Manager is run for staging the package (Windows.Management.Deployment.PackageManager)
		
		Point to note, ensure the VHD and json are in the same location as the script for this to work correctly.


		Its recommended that all scripts are signed to remove the need to elivate or change the remote execution policy on the host this script is being run.
#>


$configFPath = (Get-ChildItem $PSScriptloc -Filter *.json | Select-Object -First 1).FullName;
if ($null -eq $configFPath)
{
	throw "Missing config file Json!!";
}

$configFile = Get-Content $configFPath -Raw | ConvertFrom-Json;

foreach ($package in $configFile)
{
	$vhdSrc = Join-Path $PSScriptloc $package.vhdFileName;
	$packageName = $package.packageName;
	$parentFolder = "\" + $package.parentFolder + "\";
	$volumeGuid = $package.volumeGuid;
	$msixJunction = $package.msixJunction;
	
	try
	{
		Mount-Diskimage -ImagePath $vhdSrc -NoDriveLetter -Access ReadOnly;
		Write-Host ("Mounting of " + $vhdSrc + " was completed!") -BackgroundColor Green;
	}
	catch
	{
		Write-Host ("Mounting of " + $vhdSrc + " has failed!") -BackgroundColor Red;
	}
	
	$msixDest = "\\?\Volume{" + $volumeGuid + "}\";
	
	if (!(Test-Path $msixJunction))
	{
		New-Item $msixJunction -ItemType Directory;
	}
	
	$msixJunction = Join-Path $msixJunction $packageName;
	if (Test-Path $msixJunction)
	{
		throw "The path $msixJunction already exists!";
	}
	
	cmd.exe /c mklink /j $msixJunction $msixDest
	
	$lec = $LASTEXITCODE;
	if (0 -ne $lec)
	{
		throw "mklink returned exit code $lec";
	}
	
	[Windows.Management.Deployment.PackageManager, Windows.Management.Deployment, ContentType = WindowsRuntime] | Out-Null;
	
	Add-Type -AssemblyName System.Runtime.WindowsRuntime;
	
	$asTask = ([System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.ToString() -eq 'System.Threading.Tasks.Task`1[TResult] AsTask[TResult,TProgress](Windows.Foundation.IAsyncOperationWithProgress`2[TResult,TProgress])' })[0];
	$asTaskAsyncOperation = $asTask.MakeGenericMethod([Windows.Management.Deployment.DeploymentResult], [Windows.Management.Deployment.DeploymentProgress]);
	
	$packageManager = [Windows.Management.Deployment.PackageManager]::new();
	$path = $msixJunction + $parentFolder + $packageName;
	$path = ([System.Uri]$path).AbsoluteUri;
	$asyncOperation = $packageManager.StagePackageAsync($path, $null, "StageInPlace");
	$task = $asTaskAsyncOperation.Invoke($null, @($asyncOperation));
	$task;
}
