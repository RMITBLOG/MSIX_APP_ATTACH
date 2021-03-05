<#	
	.NOTES
	===========================================================================

	 Created on:   	05/03/2021 21:21
	 Created by:   	Ryan Mangan	
	 Organization: 	Ryan Mangansitblog.com	
	 Filename:     	MultiVM-SEC.ps1
	===========================================================================
	.DESCRIPTION
		Custom Script Extension on multiple Azure VMs
#>



param (
	$TenantId,
	$defaultSubscriptionId,
	$customScriptExtensionName,
	$scriptName,
	$storageAccountName,
	$storageAccountContainer,
	$storageAccountResourceGroup,
	$storageSubscriptionId
)

$VMs = Get-AzVM -ResourceGroupName TestGroup| # Customise how you like for WVD

Select-AzSubscription -SubscriptionId $storageSubscriptionId

$fileUri = @("https://$storageAccountName.blob.core.windows.net/$storageAccountContainer/$scriptName")
$settings = @{ "fileUris" = $fileUri };
$storageKey = (Get-AzStorageAccountKey -Name $storageAccountName -ResourceGroupName $storageAccountResourceGroup)[0].Value
$protectedSettings = @{ "storageAccountName" = $storageAccounttName; "storageAccountKey" = $storageKey; "commandToExecute" = "powershell -ExecutionPolicy Unrestricted -File $scriptName" };

Select-AzSubscription -SubscriptionId $defaultSubscriptionId

foreach ($vm in $VMs)
{
	Write-Output "Starting VM $($vm.Name)"
	Start-AzVm -ResourceGroupName "$($vm.ResourceGroupName)" -Name "$($vm.Name)"
	Write-OUtput "Working on vm $($vm.Name)"
	$extensions = (Get-AzVm -ResourceGroupName "$($vm.ResourceGroupName)" -Name "$($vm.Name)").Extensions
	foreach ($ext in $extensions)
	{
		if ($ext.VirtualMachineExtensionType -eq "CustomScriptExtension")
		{
			Write-Output "Removing CustomScriptExtension with name $($ext.Name) from vm $($vm.Name)"
			Remove-AzVMExtension -ResourceGroupName "$($vm.ResourceGroupName)" -VMName "$($vm.Name)" -Name $ext.Name -Force
			Write-Output "Removed CustomScriptExtension with name $($ext.Name) from vm $($vm.Name)"
		}
	}
	Write-Output "$customScriptExtenstionName installation on VM $($vm.Name)"
	
	Set-AzVMExtension -ResourceGroupName "$($vm.ResourceGroupName)" `
					  -Location "$($vm.Location)" `
					  -VMName "$($vm.Name)" `
					  -Name "$customScriptExtenstionName" `
					  -Publisher "Microsoft.Compute" `
					  -ExtensionType "CustomScriptExtension" `
					  -TypeHandlerVersion "1.10" `    `
					  -Settings $settings    `
					  -ProtectedSettings $protectedSettings
	
	Write-Output "---------------------------"
}