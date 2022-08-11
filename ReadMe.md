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

`./ADUnLockAccount.ps1 -User1 Homer.Simpson -User2 Marge.Simpson -OutputLogDir C:\TEMP\`



