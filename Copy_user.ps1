<#
.Synopsis
Mirror an existing user for overwriting another user. 

.Description
Generally for an established user that now has a requirement to mirror another user. Commenting out the areas which do not need to be overwritten is a good idea. 

.NOTES

#>

# Establish the variables which we will use later: felt it was necessary to force some arrays
[Array]$group = $null
[Array]$toGroupAdd = $null
[Array]$toGroupDel = $null
$fromAD = $null
$toAD = $null

$from = Read-Host "What's the username of the FROM user?"
$to = Read-Host "What's the username of the TO user?"

# Pulling each of the users in from Active Directory
$fromAD = Get-ADUser -Filter {samaccountname -like $from} -property description,manager,title,department,company
$toAD = Get-ADUser -Filter {samaccountname -like $to}



# Test verifying both users are in AD
if ($null -ne $fromAD) {
    Write-Host "User $($fromAD) is the FROM user"
    if ($null -ne $toAD) {
        Write-Host "User $($toAD) is the FROM user"

### Pull group memberships for comparison
        $toPrince = Get-ADPrincipalGroupMembership $toAD | Where-Object name -notlike 'Domain Users'
        $fromPrince = Get-ADPrincipalGroupMembership $fromAD | Where-Object name -notlike 'Domain Users'

### If a group is in the ORIGINATOR, but is not in the COPY - that group needs to be added 
        Foreach ($group in $fromPrince){
            If ($toPrince -notcontains $group){
                $toGroupAdd += $group
            }    
        }

### If a group is in the COPY, but is not in ORIGINATOR - that group needs to be removed 
        foreach ($group in $toPrince) {
            If ($fromPrince -notcontains $group){
                $toGroupDel += $group
            }
        }

### Do the user and group changes verbosely
        $toGroupAdd | ForEach-Object {Add-ADPrincipalGroupMembership -Identity $toAD -MemberOf $_ -Verbose}
        $toGroupDel | ForEach-Object {Remove-ADPrincipalGroupMembership -Identity $toAD -MemberOf $_ -Verbose}
        set-aduser $ToAD -description $fromAD.description -manager $fromAD.manager -title $fromAD.title -department $fromAd.department -company $fromAD.company -Verbose

    } Else {

### Test 2 failed to find the user
        Write-Error "No user $To"
    }
    
} Else {

## Test 1 failed to find the user
    Write-Error "No user $From"
}
