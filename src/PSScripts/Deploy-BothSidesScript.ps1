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

$global:logFile = "$PSScriptRoot\Log\BothSidesScript_" + $fileName +".log"

Log "[x] Starting deploying on BothSides script database"
$bothSidesScript = "$PSScriptRoot\Script\BikeStores_BothSides.sql"

if (Test-Path $bothSidesScript -PathType leaf) 
{
    Log "[x] Starting deploying on PRIMARY database"
    Invoke-PrimaryScript $bothSidesScript

    Start-Sleep -Seconds 2

    Log "[x] Starting deploying on SECONDARY database"
    Invoke-SecondaryScript $bothSidesScript
}
else 
{
    Log "OneSide Script Deploy: Script '$bothSidesScript' file doesn't exists"
}