# MSIX_APP_ATTACH


## Instructions:

1. Ensure all files and Virtual Disk (VHD or VHDX) are in the same folder.
2. Ensure all Scripts are signed, for a smoother expeirence as in no set-execution policy.
3. ensure you edit the configuration file (Json) with the correct information.

These scripts are recommended for testing MSIX App Attach applications.

## JSON file configuration example

The Json should look like the following example:

    "vhdFileName": "chrome.vhd",
    "parentFolder": "MSIX",
    "packageName": "Chrome_1.0.0.0_x64__ekey3h7rct2nj",
    "volumeGuid": "68c840d5-f0f2-4eac-9534-72f37cd8f864",
    "msixJunction": "C:\\temp\\AppAttach"

## MSIX Mgr 
https://aka.ms/msixmgr


# (Composite Images (CIMs))


A Cim image looks like this:

![Cim image](https://github.com/RMITBLOG/MSIX_APP_ATTACH/blob/master/TC5vlEDh.png)

The Json should look like the following example:

    "vhdFileName": "not needed",
    "parentFolder": "MSIX",
    "packageName": "Chrome_1.0.0.0_x64__ekey3h7rct2nj",
    "volumeGuid": "68c840d5-f0f2-4eac-9534-72f37cd8f864",
    "msixJunction": "C:\\temp\\AppAttach"

The guid is still needed for testing locally.

cimutil.exe m "filename.cim"

cimutil.exe d "volume guid" 

Cim images can be run in any folder directory 
update on the 01/02/2021 - Cim images can be run in any folder diretory - fixed/

The following sample applications will be uploaded in due course:

1. Pinball
2. Putty
3. MS Edge
4. Notepadpp

Ensure you install the provided certificate into the root before using these cim images with MSIX App Attach.

### Process for testing Cim images

1. ensure the cim files are placed in the root directory. This can be a mounted VHD or c:\
2. mount the cim recording the volume guid from the output
3. load the powershell scripts as a administrator
4. Run the modified staging script
5. register the App.
6. test the application.
7. de-register the app.
8. destage the app.
9. unmount the cim image
10. clean up the root directory


## Some cool tools to speed up the process....

You can use the following technologys to create MSIX Apps and pepare into MSIX App Attach quickly.

- Create MSIX Apps without any installation media https://www.appcure.io/
- CIMUTIL (community tool) - mount and dismount CIMFS DRIVE letters and volumes. both options availble. [CIMTool](https://github.com/RMITBLOG/MSIX_APP_ATTACH/tree/master/Cimfs%20tool/Cimutil%20installer) 
- CIMFS powershell Module - get-mountpoints & Get-CIMs [GetMountpoints](https://github.com/RMITBLOG/MSIX_APP_ATTACH/tree/master/Mount-Point_PSModule%20MSI)
- appventix - https://appventix.com/
- Powershell Scripts - VHD/VHDX - [App attach scripts VHD/VHDX](https://github.com/RMITBLOG/MSIX_APP_ATTACH/tree/master/VHD%20MSIX%20App%20Attach%20Scripts)
- Powershell Scripts - CIMFS - [App attach Scripts CIMFS](https://github.com/RMITBLOG/MSIX_APP_ATTACH/tree/master/Cim%20Scripts)
- Scripts to Identify CIM's and how to handle CIMFS Sprawl [CIM Management scripts](https://github.com/RMITBLOG/MSIX_APP_ATTACH/tree/master/Cim%20Scripts)

Find out more on WVD and VDI - https://ryanmangansitblog.com
