<#
.SYNOPSIS
   Call Exchange Online to output a report of all devices allowed to sync.

.DESCRIPTION 
    The logged in account must have Exchange Online Administrator (or Global Administrator) permissions. The script will reach out to Microsoft Online Services for authentication then pass those credentials into Exchange online. After authenticated, the script will pull all 'Allowed' devices in available to that logged in user and translate them into an exported CSV file. 
 
.NOTES 
    Information about the environment, things to need to be consider and other information.

.COMPONENT 
    Microsoft Online Services module, and Exhange Online modules are required. 

.LINK 
    https://github.com/Rvolvr/Powershell_AD_Scripts
 
.Parameter FILENAME
    Specifies path and name of the CSV file to be exported.
  
#>

PARAM(
    [Parameter(Mandatory,HelpMessage="Enter file name and path.")][string]$filename
)

$conglom = $null

# Easiest way to connect to Exchange is by GUI verification
Connect-MsolService
Connect-ExchangeOnline

# Grab list of "allowed" Active Sync devices to be the base dataset. 
$list = Get-MobileDevice -Filter "DeviceAccessState -EQ 'Allowed'"

$conglom = foreach ($device in $list) {
    # MobileDevice outputs a single string with name and device
    $tempName = (($device.identity).split('\'))[0]

    $ADUsers = Get-ADUser -filter "name -like '$tempName'" -Properties *

    If ($null -ne $adusers.manager){$manager =$adusers.manager.split('=,')[1]

    } else {
            $manager = "No manager added"
    }
    # This object is formatted for preference.
    [PSCustomObject]@{

        Firstname = $ADUsers.GivenName
        LastName = $ADUsers.Surname
        Mailbox = $ADUsers.UserPrincipalName
        Device = $device.FriendlyName
        DeviceID = $device.DeviceID
        FirstSyncTime = $device.FirstSyncTime
        DeviceAccessState = $device.DeviceAccessState
        Office = $ADUsers.Office
        Title = $adusers.title
        Department = $ADUsers.Department
        Manager = $manager
    }
}

$conglom | Export-Csv -path $filename
