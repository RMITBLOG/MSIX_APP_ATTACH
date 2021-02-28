<#	
	.NOTES
	==========================================================================
	 Created on:   	10/02/2021 19:51
	 Created by:   	Ryan Mangan
	 Organization: 	Ryanmangansitblog ltd
	 Filename:    grab_cimCreationtimes.ps1 	
	===========================================================================
	.DESCRIPTION
		Scipt to grab the creation dates of files. Used to collect CIMFS file creation dates/times so they can be orgainsed with the Move_CIMfiles_basedOn_creation.ps1
#>



Get-ChildItem -Path C:\Users\Ryan\Desktop\cimtest\testmove | Foreach-Object { write-output "$($_.Mode) $($_.LastWriteTime) $($_.FullName)" }