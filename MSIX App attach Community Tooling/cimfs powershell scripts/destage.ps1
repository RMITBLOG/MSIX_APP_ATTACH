# MSIX App Attach CIM TEST Ryan Mangan 2020
#
# destage script - Testing purposes only
#



$configFilePath = (Get-ChildItem $PSScriptRoot -Filter *.json | Select-Object -First 1).FullName;
if ($null -eq $configFilePath)
{
    throw "Missing JSON config!";
}

$configFile = Get-Content $configFilePath -Raw | ConvertFrom-Json;

foreach ($package in $configFile)
{
    $vhdSrc =  Join-Path $PSScriptRoot $package.vhdFileName;
    $packageName = $package.packageName;    
    $msixJunction = Join-Path $package.msixJunction $packageName;
    
    Remove-AppxPackage -AllUsers -Package $packageName;
   

    if (Test-Path $msixJunction)
    {
        Remove-Item $msixJunction -Force -Recurse;
    }
}
