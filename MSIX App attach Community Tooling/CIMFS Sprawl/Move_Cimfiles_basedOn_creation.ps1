<#	
	.NOTES
	===========================================================================
	 Created on:   	10/02/2021 19:51
	 Created by:   	Ryan Mangan
	 Organization: 	Ryanmangansitblog ltd
	 Filename:     	Move_cimfiles_basedOn_creation.ps1
	===========================================================================
	.DESCRIPTION
		Simple script to move files from a specific creation time/date range to help orgainse CIMFS images.
#>



[DateTime]$start_time = "02/06/2021 11:49:50"
[DateTime]$end_time = "02/06/2021 11:49:52"
$des_folder = "C:\Users\Ryan\Desktop\cimtest\testmove"

Get-ChildItem C:\Users\Ryan\Desktop\cimtest* -Recurse | foreach { if ($_.lastwritetime -ge $start_time -and $_.lastwritetime -le $end_time) { move-item $_.fullname $des_folder } }