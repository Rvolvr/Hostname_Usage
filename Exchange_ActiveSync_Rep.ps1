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

$conglom | Export-Csv -path $file
