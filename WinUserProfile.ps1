<#
.Synopsis
This script will remove the registries and folders of a user on a remote computer.

.Description
This is generally to be used when a user will not be on a specific machine any more, or is taking up too much space. 

.Notes
There is no way to recreate the deleted information. 
If there are any "disconnected" sessions: those will not be identified.
#>
PARAM([Parameter(Mandatory = $true)]
[String]$Computer
)
$computername = $computer.Trim()

[INT]$profile = 0
$collection = Get-CimInstance -ClassName Win32_UserProfile -ComputerName $Computername | Where-Object SID -match 'S-1-5-21'
$active = Get-WmiObject -Class Win32_ComputerSystem -computername $Computername | Select-Object UserName
$name = ($active.UserName -split '\\')[1]
Write-Host "$name is currently logged in"

foreach ($item in $collection) {
    $opt = ($item.localpath -split '\\')[2]
    If ($name -ne $opt) {
        Write-Host $profile $opt
    }else{
        Write-Host "Cannot select $name - Active User"
        $disallowed = $profile
    }
    $profile ++
}
[int]$selection = Read-Host 'Make a selection'
If ($selection -ne $disallowed){
    Write-Host "Selecting user $($collection[$selection].LocalPath) in $Computername for removal"
    Remove-CimInstance -computername $Computername $collection[$selection] -Confirm
}
