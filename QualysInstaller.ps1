#USAGE, when executed the CustomerID and Activation ID should be specified like so:
#
#.\QualysInstaller.ps1 -CustomerId {927d4ec6-6378-45ee-83b2-f9caa59f8155} -ActivationId {1dbe5ad1-a4ff-42f8-be8b-fabde2049294}
#
#This script was created to automaticly download Qualyscloudagentfrom a central store and automaticly install on the machine it was run on with 1 command line
#
#Script created by Luke England

#mandatory Parameters
Param(
    [string]$ActivationID,
    [string]$CustomerID
    )


#Hardcoded Values
#URL to reach install file
$url = "https://github.com/insightnetworks/QualysAgentHost/raw/20119756ee5246d80048007050159b247c329bd4/QualysCloudAgent.exe"
#Output file path + name
$output = "C:\Qualys\QualysCloudAgent.exe"
#start time of script for download time report
$start_time = Get-Date
#Destination Folder
$DestinationPath = "C:\Qualys"

#Check for Folder
Write-Output "Checking for folder $DestinationPath"
if (-not (Test-Path $DestinationPath)) {
        # Destination path does not exist, let's create it
        try {
            New-Item -Path $DestinationPath -ItemType Directory -ErrorAction Stop
            Write-Output "Created folder $DestinationPath"
        } catch {
            throw "Could not create path '$DestinationPath'!"
        }
    }
#Download QualysCloudAgent from repo
Write-Output "Starting download of $url"
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "File Downloaded in: $((Get-Date).Subtract($start_time).Seconds) second(s)"

#Install QualysCloudAgent
C:\Qualys\QualysCloudAgent.exe CustomerId=$CustomerId ActivationId=$ActivationId
Write-Output "C:\Qualys\QualysCloudAgent.exe Installed"