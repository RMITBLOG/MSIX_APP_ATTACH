# MSIX App Attach CIM TEST Ryan Mangan 2020
#
# deregister script - Testing purposes only
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
    Remove-AppxPackage -PreserveRoamableApplicationData $packageName
}
