# My_Useful_Powershell
This will be my non-domain specific powershell scripts that I would be able to use in other positions. 

## Hostname_Usage
Intended for a computer depot, this will add a risk assessment to using hostnames from an unverified list. The concept is based on the computer being online within the last 24-72 hours Powershell script to check if a _Hostname_ is in use and gives additional information about that _ADComputer_ object.

## Laps_Deleted
This is a internet script. The organization I work for has had computers deleted from the domain while LAPS still controlled the administrator password. Finding passwords on the deleted object is the best way to rescue that machine from having to be completely reimaged. 

## Laps_Current
This is modified Laps_Deleted to allow reference of the local administrator password.

## Managers
This takes information and updates user information that would be tied to email. 

## WinUserProfile
This is designed to reach out to a pc, list the cached users, and select one from removal. It tries to verify the active user and prevent that one from being deleted.