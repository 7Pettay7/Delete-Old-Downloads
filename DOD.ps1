# purpose of this script is to delete any downloads that are older than a specified amount of days and can email the results
# Author: 7Pettay7

# how many days old the downloads need to be to be deleted
    # NOTE: must be a negative number to ensure substraction from todays date
$daysOld = -90

# optional email info, you must have two seperate emails; one for sending and the other for receiving; only need PW for sender
    # make sure to uncomment the 'MailResults' function at the bottom of script
$sendingEmail = ""
$senderPw = ""
$receivingEmail = ""
$smtpServer = ""
$port = 0

# grabs downloads older than the specified amount of days for later use
function GetTargetDownloads() {
    $user = $env:USERNAME
    $downloads = "C:\Users\$user\Downloads"
    Get-ChildItem -Path $downloads |
        Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays($daysOld)}
}

function DeleteTargetDownloads() {
    GetTargetDownloads |
        Remove-Item -Recurse -Force
}

# function to send results to an email
function MailResults() {
    # email parameters
    $credentials = New-Object Management.Automation.PSCredential $sendingEmail,
        ($senderPw | ConvertTo-SecureString -AsPlainText -Force)
    $messageParams = @{
    Subject = "DOD Script Results"
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