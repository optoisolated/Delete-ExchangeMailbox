param (
    [Parameter(Mandatory=$False)][string]$Username
    [Parameter(Mandatory=$True)][bool]$ConfirmRemoval=$False
)

# Don't run the script if no mailbox is specified
If ($Username -eq "") {
    "Error: No Username Specified"
    "       Use the -Username switch"
    Exit
}

# Check if the mailbox rquested actually exists. 
$MailboxInfo = $Null
$MailboxInfo = Get-Mailbox $Username -ErrorAction SilentlyContinue

# If the mailbox does exist, proceed with the removal
If ($MailboxInfo -ne $Null) {
    # Identify the Database and Mailbox GUID for the mailbox. We will need them later
    $DBName = $MailboxInfo.Database.Name
    $MailboxGuid = $MailboxInfo.ExchangeGuid

    # Disable the mailbox (removing the Exchange attributes for the user, but leaving the user otherwise intact)
    # This will put the users mailbox into a disconnected state, allowing for its removal.
    "Disabling '$Username' Mailbox"
    Disable-Mailbox $Username -Confirm:$ConfirmRemoval
    
    # Wait a bit before trying to remove the disconnected mailbox
    Start-Sleep -s 5

    # Removes the mailbox using the DBName and Mailbox GUID we identified earlier
    "Removing '$Username' from DB '$DBName' with GUID '$MailboxGuid'"
    Remove-Mailbox -Database $DBName -StoreMailboxIdentity $MailboxGuid -Confirm:$ConfirmRemoval
} Else {
        "Mailbox for $Username not found."
}
""
