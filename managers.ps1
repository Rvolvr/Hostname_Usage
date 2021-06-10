<#
.SYNOPSIS
    Change the leader of individual users in bulk
.Description 
    This script will update the user (NT) with the associated manager (Manager) then fill out the organizational information.

.NOTES
    Our organization has the employee ID as the login and in the Homepage attribute. 

#>

Import-module ActiveDirectory

[array]$export = $null
$list = Import-CSV "\manager_roster.csv"



foreach ($agent in $list){
    $export += Get-ADUser $agent.NT | Set-ADUser -Manager $agent.managerID -Description $agent.title -title $agent.title -office $agent.country -homepage $agent.NT -department $agent.department 
    
}    
$export | Export-Csv ".\agent_move.csv" -NoTypeInformation
