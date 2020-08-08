#Populate Global Variables
$fileName = "$("{0:yyyyMMdd}T{0:HHmmss}" -f (Get-Date))"
$global:logFile = "$PSScriptRoot\..\Log\Trace_" + $fileName +".log" 

#Get-TimeStamp: Get formated timestamp value
# returns: string
Function Get-TimeStamp 
{
    return "[{0:MM/dd/yy} {0:HH:mm:ss.fff}]" -f (Get-Date)
}

#Log: Writes Output to log file
# returns: void
Function Log 
{
    Param
    (
        [Parameter(Position=0,Mandatory=$true)][string] $message
    )

    Write-Host $message
    Write-Output "$(Get-TimeStamp) $message" | Out-file $global:logFile -append
}