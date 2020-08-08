<##############################################################################
##  Name: CompareDatabases.ps1
##  Desc: PowerShell script to compare sql databases
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

$global:logFile = "$PSScriptRoot\Log\CompareDB_" + $fileName +".log"

Log "[x] Starting database comparison"
$newPath = "$PSScriptRoot\Script\BikeStores_Sync.sql"
$fileScript = Execute-CompareDatabase

if (Test-Path $fileScript -PathType leaf) 
{
    Log "Sync file:$fileScript found!"
    Copy-Item -Path $fileScript -Destination $newPath -force
    Log "$fileScript moved to $newPath"
}
else 
{
    Log "Sync script file doesn't exists"
}