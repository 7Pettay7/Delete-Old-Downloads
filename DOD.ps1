# purpose of this script is to delete any downloads that are older than a specified amount of days and can email the results
# Author: 7Pettay7

# how many days old the downloads need to be to be deleted
    # NOTE: must be a negative number for the script to subtract from the current date
$daysOld = -90

# optional email inputs, see below for examples
    # make sure to uncomment the 'MailResults' function at the bottom of script if you would like to use this feature
$sendingEmail = "" # sender@gmail.com
$senderPw = "" # SenderPassword123
$receivingEmail = "" # recipient@gmail.com
$smtpServer = "" # smtp.gmail.com
$port = 0 # 587

# grabs downloads older than the specified amount of days
function GetTargetDownloads() {
    $user = $env:USERNAME
    $downloads = "C:\Users\$user\Downloads"
    Get-ChildItem -Path $downloads |
        Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays($daysOld)}
}

function DeleteTargetDownloads() {
    GetTargetDownloads |
        Remove-Item -Recurse -Force -WhatIf
}

# function to put together all email info and send results
function MailResults() {
    $credentials = New-Object Management.Automation.PSCredential $sendingEmail,
        ($senderPw | ConvertTo-SecureString -AsPlainText -Force)
    $messageParams = @{
    Subject = "Downloads Deleted - DOD"
    Body = GetTargetDownloads |
        Sort-Object -Property LastWriteTime -Descending |
        Select-Object Name,LastWriteTime |
        ConvertTo-Html |
        Out-String
    From = $sendingEmail
    To = $receivingEmail
    SmtpServer = $smtpServer
    Port = $port
    Credential = $credentials
    UseSsl = $True
    BodyAsHtml = $True
    }

    Send-MailMessage @messageParams
}

# start script
#MailResults
DeleteTargetDownloads