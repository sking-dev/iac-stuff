###########################################################
# AUTHOR  : sking-dev
# DATE    : 2022-03-30
# EDIT    : 2022-03-30
# COMMENT : This script retrieves the official list of Office 365 endpoints worldwide in CSV format from the Microsoft API.
#         : It then parses the comma-delimited values for 'urls' (FQDNs) and outputs a single unified string array.
#         : This string array can then be copied for use in Terraform code for Azure Firewall application rules ('destination_addresses')
#
# VERSION: 1.0.0
###########################################################

#----------------------------------------------------------
# NOTES
#----------------------------------------------------------
# 2022-03-30 : [sking-dev] v1.0.0.

#----------------------------------------------------------
# CHANGELOG
#----------------------------------------------------------
# 2022-03-30 : [1.0.0] [sking-dev]

#----------------------------------------------------------
# PARAMETERS
# Important: this needs to be the first code after the comments, otherwise it won't be acknowledged.
#----------------------------------------------------------
# Add any parameters here.

#----------------------------------------------------------
# ERROR REPORTING ALL
#----------------------------------------------------------
Set-StrictMode -Version Latest

#----------------------------------------------------------
# ERROR HANDLING
#----------------------------------------------------------
<# Change this to "Stop" in order to modify the behaviour of errors script-wide, so that they behave like exceptions.
By default, errors are logged but do not cause a runbook / script to stop, versus exceptions which *do* cause a script to stop.
NOTE: Some people consider it bad practice to set this globally; instead, use '-ErrorAction Stop' on a per cmdlet basis. #>
# $ErrorActionPreference = "Stop"

#----------------------------------------------------------
# DEFINE OUTPUT COLOURS
#----------------------------------------------------------
# Output colours can't be used with 'Write-Output' as they only work with 'Write-Host'.
# Example syntax included for future reference.
<#
$infoColours    = @{foreground="cyan"}
$warningColours = @{foreground="yellow"}
$errorColours   = @{foreground="red"}
$debugColours   = @{foreground="green";background="blue"}
#>

#----------------------------------------------------------
# STATIC VARIABLES
#----------------------------------------------------------
$ws = "https://endpoints.office.com"
$instance = "Worldwide"
$format = "CSV"
$clientRequestId = [GUID]::NewGuid().Guid

#----------------------------------------------------------
# START FUNCTIONS
#----------------------------------------------------------
# Add any functions here.

#----------------------------------------------------------
# MAIN PROGRAM BLOCK
#----------------------------------------------------------
# Download the Microsoft published list of Office 365 endpoints worldwide.
$endpointSets = Invoke-RestMethod -Uri ($ws + "/endpoints/" + $instance + "?Format=" + $format + "&clientRequestId=" + $clientRequestId)

# Export the Microsoft published list to a CSV file.
Write-Output $endpointSets | Out-File office-365-endpoints-all.csv

# Extract the 'ids' and 'urls' columns.
$newFile = Import-Csv .\office-365-endpoints-all.csv | Select-Object id,urls

# Export the filtered comma-delimited values into a new CSV file.
$newFile | Export-Csv -Path .\office-365-endpoints-urls-only.csv -NoTypeInformation

# Part Deux: combine the comma-delimited values in each row into a single string array to use in the Terraform code.

# First, create an array and populate it with the values from the 'urls' column.
# https://www.spguides.com/powershell-create-array-from-csv/
# NOTE: There's an annoying empty value in the original Microsoft list, and this needs to be removed otherwise Terraform will grumble.
# https://www.powershelladmin.com/wiki/Remove_empty_elements_from_an_array_in_PowerShell.php

$urls=@()
Import-Csv .\office-365-endpoints-urls-only.csv | ForEach-Object {
    $urls += $_.urls  | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
}

# Next, split the values in each cell into separate rows so that each value will retain its quotation marks.
# https://stackoverflow.com/questions/60672095/powershell-convert-comma-separated-values-into-separate-objects

$urlsSplit = $urls.Split(",")
$urlsSplit
Write-Host("================")

# Finally join the values from the individual rows into a single string array.
# https://morgantechspace.com/2021/01/how-to-join-string-array-into-one-string-in-powershell.html

$urlsJoined = '"' + ($urlsSplit -join '","' ) + '"'

# Replace the unsupported placeholder value in this individual FQDN with the explicit name of your tenant directory.
$urlsJoined = $urlsJoined -replace "autodiscover.*.onmicrosoft.com", "autodiscover.mytenantdirectory.onmicrosoft.com"

# Output the finalised joined string for use in the Terraform code.
Write-Host "[User action required] Copy the output below and paste it into your Terraform code."
Write-Host "================"
$urlsJoined

###########################################################
# END OF SCRIPT: office-365-output-endpoint-urls-terraform-friendly.ps1
###########################################################
