<#
#########################################################################################
# Update-WithLatestDatabaseCode Script                                                  #
#                                                                                       #
# Version 1.0                                                                           #
# 07/01/2020                                                                            #
#                                                                                       #
# Marcelo Claure                                                                        #
#########################################################################################
#>

# Load Modules
. "$PSScriptRoot\Module\Variables.ps1"
. "$PSScriptRoot\Module\Logger.ps1"
. "$PSScriptRoot\Module\DataAccessLayer.ps1"
. "$PSScriptRoot\Module\CustomModule.ps1"

$global:logFile = "$PSScriptRoot\Log\UpdateDBCode_" + $fileName +".log"

Log "[x] Starting execution"

Invoke-DemoQuery $queries.init_db "master"

if(Test-Path $demoFileScript)
{
    Invoke-DemoScript $demoFileScript
    Log "[x] Database was initialized"
}
else
{
    Log "[x] Database script doesn't exists. Please check that the database was succefully downloaded from repository"    
}