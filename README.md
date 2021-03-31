# Delete-ExchangeMailbox
PowerShell script to allow for simple deletion of an Exchange Mailbox without removing the AD User object.

## How to use the script
From the Exchange Management Console, run the script as follows

.\Delete-ExchangeMailbox.ps1 -Username <user> -Confirm $False

* -Username: The alias, UPN or SAmAccountName of the user
* -Confirm: $True or $False (will prompt for confirmation of the disconnection and then deletion of the mailbox)
