<#
.Synopsis
This script will remove the registries and folders of a user on a remote computer.

.Description
This is generally to be used when a user will not be on a specific machine any more, or is taking up too much space. 

.Notes
There is no way to recreate the deleted information. 
If there are any "disconnected" sessions: those will not be identified.
#>

$machine = Read-Host 'State computer to list users'

# Pull information from machine, filter out non-domain users.
$collection = Get-CimInstance -ClassName Win32_UserProfile -ComputerName $machine -ErrorAction Stop | Where-Object SID -match 'S-1-5-21'


# Pull the name of the active user.
$active = Get-WmiObject -Class Win32_ComputerSystem -computername $machine | Select-Object UserName

# Clean up the active user information.
$name = $($active.UserName -split '\\')[1]
Write-Warning -Message "$name is currently logged in"

# Start the selection menu.
[INT]$profile = 0
foreach ($item in $collection) {
    $opt = ($item.localpath -split '\\')[2]
    If ($name -ne $opt) {
        Write-Output "$profile $opt"

    }Else{
        Write-Warning -Message "Cannot select $name - Active User"
        $disallowed = $profile
    }
    $profile ++
}

$profile --
[INT]$selection = Read-Host 'Make a selection'

# Prevent active user from selection, then remove identified user.
if ($selection -le $profile) {

## If/else to show show the active user within the selection menu.
    If ($selection -ne $disallowed){
        Write-Warning -Message "Selecting user $($collection[$selection].LocalPath) in $machine for removal"
        Remove-CimInstance -computername $machine $collection[$selection] -Confirm

    } Else {
        Write-Error -Message 'Cannot delete Active user'
    }

} Else {
    Write-Error -Message "$selection was not a valid input. Options go to $profile."
}