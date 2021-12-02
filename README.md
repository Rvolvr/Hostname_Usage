# My_Useful_Powershell

This will be my non-domain specific powershell scripts which could be helpful to IT personnel starting in a new environment. These scripts are intended to be copied and pasted to the user's computer for running and tweaking. Once on a user's computer, feel free to modify the script to your own needs.

## [Snip_drop](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/snip_drop.ps1)

These are a series of copy/paste snippets that can be copied into a new computer to help configure brand new Windows installs to do the various tasks - help system prep until a main imaging system can be utilized. There is an exit line specifically to prevent a full run of the script - this could also be done by removing the file extension, but I prefer the colors in coding sources.

## [Copy_User](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Copy_user.ps1)

Reads the various fields in Active Directory and moves them to the second user, then compares the Group Memberships to realign the new user. I chose the complex way of comparison, rather than just removing all and then adding them back.

## [Domain-User-Term](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Domain-User-Term.ps1)

Removes user from all group memberships, then disables and changes the description to show termination and date. This also removes deletion protection so the user can be manually moved. Since moving requires domain specific information, it has been omitted.

## [Update_Office](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Update_Office.ps1)

Sets off an update for the "Click to Run" version of Office on a remote machine using PSSession.

## [Managers](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/managers.ps1)

Convert a CSV into  multiple user settings which then fills out an Active Directory organization. These feilds are generally the ones tied to Teams and Exchange (Outlook).

## [WinUserProfile](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/WinUserProfile.ps1)

This script is for proper removal of the user from a computer, including cached files. It tries to verify the active user and prevent that one from being deleted. Future update will look for disconnected sessions as well. These files do not go to a recycle bin.

## [Hostname_Usage](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/hostname_used.ps1)

Intended for a computer depot, this will add a risk assessment to using hostnames from an unverified list. The concept is based on the computer being online within the last 24-72 hours Powershell script to check if a _Hostname_ is in use and gives additional information about that _ADComputer_ object. This is a niche requirement, but I also reference how to use these commandlets.

## [Laps_Deleted](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Laps_Deleted.ps1)

Script is originally from a the internet, kept for reference. The organization I work for has had computers deleted from the domain while LAPS still controlled the administrator password. Finding passwords on the deleted object is the best way to rescue that machine from having to be completely reimaged.

## [Laps_Current](https://github.com/Rvolvr/Powershell_AD_Scripts/blob/main/Laps_Current.ps1)

This is modified Laps_Deleted to allow reference of the local administrator password. Microsoft has a GUI for this.
