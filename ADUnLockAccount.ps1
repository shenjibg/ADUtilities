<#

	.SYNOPSIS
	Simple Unlock routine for a user account that is locked.

	.DESCRIPTION
	This script takes in AD UserNames and tests if they are Unlocked.  If they are locked then it unlocks the account and makes a log entry.
		
	.PARAMETER User1
	A string of the Username

    .PARAMETER User2
    A string of the Username

    .PARAMETER OutputLogDir
    A string for the log directory

    .PARAMETER emailCred
    A pscredential if there is a email to be sent.

    .PARAMETER smtpServer
    The SMTP Address.

    .PARAMETER smtpPort
    The SMTP Port.

    .PARAMETER emailFrom
    Originating email source.

    .PARAMETER emailTo
    Email destination.

    
#>

[CmdletBinding()]
param (
    [Parameter()]
    [string] $User1 = '',
    [string] $User2 = '',
    [string] $OutputLogDir = $env:TEMP,
    [pscredential] $emailCred = $null,
    [string] $smtpServer = 'smtp.office365.com',
    [Int32] $smtpPort = 587,
    [string] $emailFrom = '',
    [string] $emailTo = ''
)

Import-Module ActiveDirectory

[System.Text.StringBuilder] $logResults = New-Object -TypeName "System.Text.StringBuilder";

Function getUser
{
    param([string] $userName)
    $result = $null
    if(-not([System.String]::IsNullOrWhiteSpace($userName)))
    {
      $result = Get-ADUser -identity $userName -properties LockedOut 
    }

    return $result
}

Function testUser
{
    param([string] $userName)

    $user = getUser($userName)

    If(-not($null -eq $user) -and ($user.LockedOut -eq $true))
    {
        UnLock-ADAccount $userName
        $messageText = "User: {0} was locked. Unlock command issued." -f($userName)
        $logResults.AppendLine($messageText)
    }
}


$dateStr = Get-Date -Format("yyyy_MM_dd").ToString()
$dateTimeStr = Get-Date -Format("yyyy_MM_dd_HH_mm").ToString()
$logFileName = "{0}\Log_ADUnLockAccounts_{1}.log" -f($OutputLogDir,$dateStr)
$startLog = "Script run at {0}" -f($dateTimeStr)
$logResults.AppendLine($startLog)

If(-not([System.String]::IsNullOrWhiteSpace($User1)))
{
    testUser($User1)    
}

If(-not([System.String]::IsNullOrWhiteSpace($User2)))
{
    testUser($User2)    
}


IF(-not(Test-Path -Path $logFileName -PathType Leaf))
{
    #Not there need to create
    
    New-Item -Path $logFileName -ItemType File    
    
}

Add-Content -Path $logFileName -Value $logResults.ToString()

#EnterCredentialCode

IF(-not($emailCred -eq $null ))
{
    $emailSubj = 'AD unlock {0}' -f($dateTimeStr)
    Send-MailMessage -SmtpServer $smtpServer -Port $smtpPort -UseSsl -From $emailFrom -To $emailTo -Subject $emailSubj -Body $logResults.ToString() -Credential $emailCred

}