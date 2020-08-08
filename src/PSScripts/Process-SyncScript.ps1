<##############################################################################
##  Name: Process-SyncScript.ps1
##  Desc: PowerShell script to process Syncronization SQL script
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

$global:logFile = "$PSScriptRoot\Log\ProcessScript_" + $fileName +".log"

Log "[x] Starting Sync Script processing"
$fileScript = "$PSScriptRoot\Script\BikeStores_Sync.sql"
$oneSideScript = "$PSScriptRoot\Script\BikeStores_OneSide.sql"
$bothSidesScript = "$PSScriptRoot\Script\BikeStores_BothSides.sql"

if (Test-Path $fileScript -PathType leaf) 
{
    $header = Get-Content $fileScript -First 6
    $fileData = Get-Content $fileScript
    $footer = "GO"  

    $oneSide = New-Object System.Collections.ArrayList
    $bothSides = New-Object System.Collections.ArrayList

    $position = 0
    $start = 0
    $end = 1
    $i = 12
    $limit = $($fileData.count)

    $oneSide.Add($header) > $null
    $bothSides.Add($header) > $null
       
    while($i -lt $limit)
    {
        $start = $i
        $position = $i
        $subHeader = ""
        
        if($fileData[$position].StartsWith('ALTER TABLE'))
        {
            $object = ($fileData[$position]).Substring(12,((($fileData[$position]).Substring(12)).IndexOf(' ')))
            $subHeader = "PRINT N'Altering $object'"
            $found = 0

            while($found -eq 0) 
            {
               if($position -lt $limit)
               {
                 if($fileData[$position].StartsWith('GO'))
                 {
                   $found = 1
                 }
                 else 
                 {
                   $position = $position + 1
                   $found = 0                            
                 }
               }
               else 
               {
                 $found = 1
                 $position = $limit - 2
               }
            }

            $end = $position + 2
            $oneSide.Add("GO") > $null            
            $oneSide.Add($subHeader) > $null
            $oneSide.Add("GO") > $null                   
            $oneSide.Add($fileData[$start..$end]) > $null
        }            
        elseif($fileData[$position].StartsWith('ALTER PROCEDURE'))
        {
            $object = ($fileData[$position]).Substring(16)
            $subHeader = "PRINT N'Altering $object'"
            $found = 0       

            while($found -eq 0) 
            {
                if($position -lt $limit)
                {
                    if($fileData[$position].StartsWith('GO'))
                    {
                        $found = 1
                    }
                    else 
                    {
                        $position = $position + 1
                        $found = 0                           
                    }
                }
                else 
                {
                    $found = 0
                    $position = $limit - 2
                }
            }

            $end = $position + 2          
            $bothSides.Add($subHeader) > $null
            $bothSides.Add("GO") > $null
            $bothSides.Add($fileData[$start..$end]) > $null
        }
        else
        {
            $end =  $position + 1 
        }

        $i = $end                        
    }

    $oneSide.Add($footer) > $null
    $bothSides.Add($footer) > $null

    $oneSide | Out-File -FilePath $oneSideScript -Force
    $bothSides | Out-File -FilePath $bothSidesScript -Force

    if (Test-Path $oneSideScript -PathType leaf) { Log "One-Side Script: '$oneSideScript' was generated successfully."}
    if (Test-Path $bothSidesScript -PathType leaf) { Log "Both-Sides Script: '$bothSidesScript' was generated successfully."}   
}
else 
{
    Log "Process-SyncScript: Sync script file doesn't exists and we can't continue"
}