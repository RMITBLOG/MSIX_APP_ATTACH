<#	
	.NOTES
	===========================================================================
	 Created on:   	10/02/2021 19:33
	 Created by:   	Ryan Mangan
	 Organization: 	Ryanmangansitblog ltd
	 Filename:     	CIMorganise.ps1
	===========================================================================
	.DESCRIPTION
		This script grabs all Region and Object files as well as the CIM file and moves them to a new destination.
		This is useful for those who have what is called CIMFS sprawl where all the object and region files are mixed in one folder making it 
		difficult to identify the differenc cims you may have.
		
		Instructions of use:
		take the CIM Guid from the region or object file , it should look something like this "a3014df2-1a4b-42cf-945c-ec6d8721e142", then enter into the
		into the guid varible. Do the same for the cim file. you only need the name, the extention is not required as its handled within the script function.

#>

#Script config details:
$GUID = "a3014df2-1a4b-42cf-945c-ec6d8721e142"
$cim = "testapp"
$SR = "C:\Users\Ryan\Desktop\msixaatesting\msix\foxitcim"
$DST = "C:\Users\Ryan\Desktop\msixaatesting\msix\foxitcim\testmove"

#script actions:
get-childitem -Recurse -path $SR -filter "*$GUID*" | move-item -Destination "$DST"
get-childitem -Recurse -path $SR -filter "*$cim*.cim" | move-item -Destination "$DST"