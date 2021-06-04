<#
.SYNOPSIS
    Change the leader of individual users in bulk
.Description 
    This script will update the user (WIN) with the associated manager (Manager)

.NOTES
    Boise Specific

#>

Import-module ActiveDirectory



$list = Import-CSV "\manager_roster.csv"
#$logdir = "$ScriptDir\logs"
#$date = Get-Date -Format d | ForEach-Object {$_ -replace "/", "."}


foreach ($agent in $list){
    $export += Get-ADUser $agent.NT | Set-ADUser -Manager $agent.managerID -Description $agent.title -title $agent.title -office $agent.country -homepage $agent.NT -department $agent.department 
    
}    
$export | Export-Csv ".\agent_move.csv" -NoTypeInformation
