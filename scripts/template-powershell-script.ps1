###########################################################
# AUTHOR  : [Username / identifier]
# DATE    : YYYY-MM-DD [date of version 1.0.0]
# EDIT    : YYYY-MM-DD [date of latest change]
# COMMENT : What is the script for / what does it do?  Include a work item reference where possible.
#
# VERSION: 1.0.0
###########################################################

#----------------------------------------------------------
# NOTES
#----------------------------------------------------------
# YYYY-MM-DD : [Username / identifier] Add any notes as required.

#----------------------------------------------------------
# CHANGELOG
#----------------------------------------------------------
# YYYY-MM-DD : [Version] [Username / identifier] Add any change details as required.

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
NOTE: Some people consider it bad practice to set this globally; instead, use "-ErrorAction Stop" on a per cmdlet basis. #>
# $ErrorActionPreference = "Stop"

#----------------------------------------------------------
# DEFINE OUTPUT COLOURS
#----------------------------------------------------------
# Output colours can't be used with Write-Output (they only work with Write-Host)  Example syntax left for future reference.
<#
$infoColours    = @{foreground="cyan"}
$warningColours = @{foreground="yellow"}
$errorColours   = @{foreground="red"}
$debugColours   = @{foreground="green";background="blue"}
#>

#----------------------------------------------------------
# STATIC VARIABLES
#----------------------------------------------------------
# Add any static variables here.

#----------------------------------------------------------
# START FUNCTIONS
#----------------------------------------------------------
# Add any functions here.

#----------------------------------------------------------
# MAIN PROGRAM BLOCK
#----------------------------------------------------------
# Add the body of the script here.

###########################################################
# END OF SCRIPT: [script-name].ps1
###########################################################
