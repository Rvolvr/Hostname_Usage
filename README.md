# My_Useful_Powershell
This will be my non-domain specific powershell scripts that I would be able to use in other positions. 

## Hostname_Usage.ps1
Intended for a computer depot, this will add a risk assessment to using hostnames from an unverified list. The concept is based on the computer being online within the last 24-72 hours Powershell script to check if a _Hostname_ is in use and gives additional information about that _ADComputer_ object.

## Laps_Deleted.ps1
This is a internet script. The organization I work for has had computers deleted from the domain while LAPS still controlled the administrator password. Finding passwords on the deleted object is the best way to rescue that machine from having to be completely reimaged. 

## Laps_Current.ps1
This is modified Laps_Deleted to allow reference of the local administrator password.

## Managers.ps1
This takes information and updates user information that would be tied to email. 

## WinUserProfile.ps1
This script is for proper removal of the user from a computer, including cached files. It tries to verify the active user and prevent that one from being deleted. Future update will look for disconnected sessions as well. These files do not go to a recycle bin. 
