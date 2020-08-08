<##############################################################################
##  Name: Deploy-OneSideScripts.ps1
##  Desc: PowerShell script to Deploy One-Side Scripts
##
##  Author: Marcelo Claure
##
##  Created:
###############################################################################
##                            Change History
###############################################################################
##  Date:       Author:			Description:
##  --------    --------		----------------------------------------------------
##	2020-08-01	Marcelo Claure  Initial Creation
###############################################################################>
# Load Modules
. "$PSScriptRoot\Module\Variables.ps1"
. "$PSScriptRoot\Module\Logger.ps1"
. "$PSScriptRoot\Module\DataAccessLayer.ps1"
. "$PSScriptRoot\Module\CustomModule.ps1"

$global:logFile = "$PSScriptRoot\Log\OneSideScript_" + $fileName +".log"
$oneSideScript = "$PSScriptRoot\Script\BikeStores_OneSide.sql"

if (Test-Path $oneSideScript -PathType leaf) 
{
    Log "[x] Starting deploying on PRIMARY database"
    Invoke-PrimaryScript $oneSideScript
    Start-Sleep -Seconds 2
}
else 
{
    Log "OneSide Script Deploy: Script '$oneSideScript' file doesn't exists"
}