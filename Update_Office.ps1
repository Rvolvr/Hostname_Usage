<#
.Description
Sets off an update for the "Click to Run" version of Office.

.Notes
This enters a PS Session, admin credentials may be required. The PSSession is closed upon exit.
#>

#Pull list of names from a docuemnt
$collection = Get-Content '.\office_list.csv'

#Option to use an admin account
$sesh = Get-Credential

foreach ($item in $collection) {
    #test to see if computer in list is online
    $online = Test-Connection $item -Verbose
    if ($true -eq $online) {
        #open a remote session on the named computer and run the update.
        Enter-PSSession -ComputerName $item -Credential $sesh
        # Here is the work.
        Set-Location 'C:\Program Files\Common Files\microsoft shared\ClickToRun\'
        & .\OfficeC2RClient.exe /changesetting Channel=Current
        & .\OfficeC2RClient.exe /update user
        #This will close the session.
        Exit-PSSession
    }
}
