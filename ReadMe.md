# Active Directory Quick Unlock
## Installation
Make sure the machine you are working on has the Module ActiveDirectory


To check:
Enter `Get-Module`

It should return:
| ModuleType | Version   | Name                                |ExportedCommands                      |                                                                         
|---------- | ------- |   ----                                |----------------                                                                                       |        
|Manifest |   1.0.1.0   | ActiveDirectory  |...|

If this is not returned install the ActiveDirectory Module

**You might have to sign the code**
[Powershell Code signing](https://devblogs.microsoft.com/scripting/hey-scripting-guy-how-can-i-sign-windows-powershell-scripts-with-an-enterprise-windows-pki-part-2-of-2/)

## Running the command
**Use the program "Task Scheduler" is best on your domain controller**

### Example
This will do the following
| Parameter | Description | Value| What it will do |
| --------- | ----------- | -----| --------------- |
|User1 | Program allows 2 user names to test and unlock. | Homer.Simpson | It will look for the user Homer.Simpson and then if that account is locked unlock it. |
|User2 | Program allows 2 user names to test and unlock. | Marge.Simpson | It will look for the user Marge.Simpson and then if that account is locked unlock it. |
|OutputLogDir| This is the directory to output the log files. | C:\Temp\ | This will log to the directory C:\Temp\ a *.log file.  If one is not provided it will use the user's temporary directory. |
|emailCred | PS Credential to log into Office 365 | Needs you to run code below Example 3 | Sets up the login credential | 
| smtpServer | The SMTP server to send the email. | smtp.office365.com | |
| smtpPort | The port that is used for SMTP. | 587 | |
| emailFrom | The email address that is originating. | | |
| emailTo | The email address that is destination. | | |

`./ADUnLockAccount.ps1 -User1 Homer.Simpson -User2 Marge.Simpson -OutputLogDir C:\TEMP\`

## Example 3 how to create credentials to pass.
`
$userName = 'blah@office365.com'
$password = 'asdfghjkl;'
[SecureString]$securepassword = $password | ConvertTo-SecureString -AsPlainText -Force 
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $securepassword
`
Use the $credential variable to pass in or change its' name to $emailCred in the script at `#EnterCredentialCode`.




