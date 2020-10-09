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


## (Composite Images (CIMs))

The Json should look like the following example:

    "vhdFileName": "not needed",
    "parentFolder": "MSIX",
    "packageName": "Chrome_1.0.0.0_x64__ekey3h7rct2nj",
    "volumeGuid": "68c840d5-f0f2-4eac-9534-72f37cd8f864",
    "msixJunction": "C:\\temp\\AppAttach"

The guid is still needed for testing locally.

cimutil.exe m "filename.cim"

cimutil.exe d "volume guid" 

Cim images must be run on the root directory when tesing.


## Some cool tools to speed up the process....

You can use the following technologys to create MSIX Apps and pepare into MSIX App Attach quickly.

- Create MSIX Apps without any installation media https://www.appcure.io/
- MSIX App attach ready in Seconds - https://www.appattach.co.uk/ 



Find out more on WVD and VDI - https://ryanmangansitblog.com
