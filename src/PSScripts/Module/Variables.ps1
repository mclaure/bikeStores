#Populate Global Variables
$queries = Import-PowerShellDataFile -Path "$PSScriptRoot\..\Config\Queries.psd1"
$credentials = Import-PowerShellDataFile -Path "$PSScriptRoot\..\Config\Credentials.psd1"
$demoFileScript = "d:\Program Files (x86)\Jenkins\workspace\Demo\database\BikeStoresDB.sql"
$sqlCompareEXE = "D:\Program Files (x86)\Red Gate\SQL Compare 12\SQLCompare.exe"