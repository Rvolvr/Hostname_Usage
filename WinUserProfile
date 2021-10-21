$machine = read-host "Set computer from which to list users"
#Pull information from machine, filter out non-domain users
$collection = Get-CimInstance -ClassName Win32_UserProfile -ComputerName $machine | Where-Object {$_.SID -match "S-1-5-21"}
#Pull the name of the active user
$active = Get-WmiObject -Class Win32_ComputerSystem -computername $machine | Select-Object UserName
#clean up the active user information
$name = $($active.UserName -split '\\')[1]
Write-Host "$name is currently logged in"
#Start the selection menu
[INT]$profile = '0'
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
[int]$selection = Read-Host "Make a selection"
#Prevent active user from selection, then remove identified user
If ($selection -ne $disallowed){
    Write-Host "Selecting user $($collection[$selection].LocalPath) in $machine for removal"
    Remove-CimInstance -computername $machine $collection[$selection]
}
