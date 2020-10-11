# MSIX App Attach CIM TEST Ryan Mangan 2020
#
# register script - Testing purposes only
#







$configFilePath = (Get-ChildItem $PSScriptRoot -Filter *.json | Select-Object -First 1).FullName;
if ($null -eq $configFilePath)
{
    throw "Missing JSON config!";
}




$configFile = Get-Content $configFilePath -Raw | ConvertFrom-Json;

foreach ($package in $configFile)
{
    $packageName = $package.packageName;
    $path = Join-Path $env:ProgramFiles ("WindowsApps\" + $packageName + "\AppxManifest.xml");
    Add-AppxPackage -Path $path -DisableDevelopmentMode -Register;
}
