<#	
	.NOTES
	===========================================================================
	 Created on:   	05/03/2021 17:57
	 Created by:   	Ryan Mangan
	 Organization: 	RyanMangansitblog.com
	 Filename:     	MSIXAA install Cert
	===========================================================================
	.DESCRIPTION
		Script to install Certs on to Session hosts on Windows Virtual Desktop for MSIX App Attach

		Step 1. Add your certificate to public blob storage.
		Step 2. Enter the blob path into this script.
		Step 3. Enter the output.
		Step 4. Enter the password for the Cert.

#>

#Installing Certificates to Session hosts for MSIX App Attach


#Edit Config Here
#
#
#
#--------------------------------------------------------
$Certpath = "https://xxxxx.blob.core.windows.net/cert/MyDevCert2.pfx"
$Output = "C:\temp\MyDevCert2.PFX"
$password = "test123"
#-------------------------------------------------------
#
#
#


{
	# Do Not Change
	$secureString = convertto-securestring "test123" -asplaintext -force
	$Certlm = "Cert:\LocalMachine\TrustedPeople"
	
	
	#Cert from Azure Files
	invoke-WebRequest -Uri $Certpath -OutFile $Output
	Start-Sleep -s 1
	
	Get-ChildItem -Path cert:\LocalMachine\TrustedPeople
	Import-PfxCertificate -FilePath $Output -CertStoreLocation $Certlm -Password $secureString
} # Script function


