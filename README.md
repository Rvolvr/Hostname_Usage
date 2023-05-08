# My_Useful_Powershell

These are going to be transferred to GISTS as soon as I find time. I will also be correctly identifying PARAM in the transition.

This will be my non-domain specific powershell scripts which could be helpful to IT personnel starting in a new environment. I will be happy to modify these for user specific needs - add a [Discussion](https://github.com/Rvolvr/Powershell_AD_Scripts/discussions "Powershell Discussion") or [Issue](https://github.com/Rvolvr/Powershell_AD_Scripts/issues "PowerShell Issue"). This will be my non-domain specific powershell scripts which could be helpful to IT personnel starting in a new environment. These scripts are intended to be copied and pasted to the user's computer for running and tweaking. Once on a user's computer, feel free to modify the script to your own needs.

## [Snip_drop](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/snip_drop.ps1)

These are a series of copy/paste snippets that can be copied into a new computer to help configure brand new Windows installs to do the various tasks - help system prep until a main imaging system can be utilized. There is an exit line specifically to prevent a full run of the script - this could also be done by removing the file extension, but I prefer the colors in coding sources.

## [Copy_User](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Copy_user.ps1)

Reads the various fields in Active Directory and moves them to the second user, then compares the Group Memberships to realign the new user. I chose the complex way of comparison, rather than just removing all and then adding them back.

## [HomeDirectory_Creation]("TBD")
Pulls user information from Active Directory and creates Home Directory folder with corresponding user security settings.

## [LAPS_Deleted](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Laps_Deleted.ps1)

Script is originally from a the internet, kept for reference. The organization I worked for had computers overwritten with the same name in the domain while LAPS still controlled the administrator password. Finding passwords on the deleted object is the best way to rescue that machine from having to be completely reimaged. This can now be right-clicked and `Run in PowerShell` from the file in Explorer.

## [LAPS_Current](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Laps_Current.ps1)

This is modified Laps_Deleted to allow reference of the local administrator password. Microsoft has a GUI for this. This can now be right-clicked and `Run in PowerShell` from the file in Explorer.

## [Domain-User-Term](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Domain-User-Term.ps1)

Removes user from all group memberships, then disables and changes the description to show termination and date. This also removes deletion protection so the user can be manually moved. Since moving requires domain specific information, it has been omitted.

## [Update_Office](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Update_Office.ps1)

Sets off an update for the "Click to Run" version of Office on a remote machine using PSSession.

## [WinUserProfile](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/WinUserProfile.ps1)

Best used to free up space by removing old users with huge Outlook OST/PST files. This script is for proper removal of the user from a computer, including local files. It tries to verify the active user and prevent that one from being deleted. These files do not go to a recycle bin. Future update will look for disconnected sessions as well.

## [SplitDbxContent.ps1]("TBD")

This script seems absent from the Windows PS Gallery. My organization downloaded the file before the removal, so I am placing a copy here for future use. This file is referenced to fix "Hole in my Boot" UEFI insecurities and is referenced from [Microsoft guidance for applying Secure Boot DBX update (KB4575994)](https://support.microsoft.com/en-gb/topic/microsoft-guidance-for-applying-secure-boot-dbx-update-kb4575994-e3b9e4cb-a330-b3ba-a602-15083965d9ca). 

In case the page gets removed, the binaries are here [UEFI REVOCATION LIST FILE](https://uefi.org/revocationlistfile) and the code to use them is:

```PowerShell
# Reference your DBX file and split into signature.p7 and content.bin.
SplitDbxContent.ps1 “c:\path\to\file\dbxupdate.bin"

# Use referenced files to set the Secure Boot. The addition of that specific time information was not listed in the referece documentation.
Set-SecureBootUefi -Name dbx -ContentFilePath .\content.bin -SignedFilePath .\signature.p7 -Time 2010-03-06T19:17:21Z -AppendWrite
```

## [Managers](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/managers.ps1)

Convert a CSV into  multiple user settings which then fills out an Active Directory organization. These fields are generally the ones tied to Teams and Exchange (Outlook), but will need to be customized to the CSV.

## [Hostname_Usage](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/hostname_used.ps1)

Intended for a computer depot, this will add a risk assessment to using hostnames from an unverified list. The concept is based on the computer being online within the last 24-72 hours Powershell script to check if a _Hostname_ is in use and gives additional information about that _ADComputer_ object. This is a niche requirement, but I also reference how to use these commandlets.
