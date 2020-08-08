# Execute-CompareDatabase: Executes SQL Compare comparison
# returns: void
Function Execute-CompareDatabase
{
    $outputFolder = "$PSScriptRoot\Output\Results" + (Get-Date -f yyyyMMddHHmmss)
    $reportFile = "BikeStores_Comparison_Results.html"
    $scriptFile = "BikeStores_Sync.sql"    
    New-Item -ItemType directory -Path $outputFolder > $null

    $scriptFile = $outputFolder + "\" + $scriptFile

    $demo = $credentials.demo
    $primary = $credentials.primary  
    
    $demoInfo = " /s1:" + $($demo.serverInstance) + " /db1:" + $($demo.database) + " /userName1:" + $($demo.user) + " /password1:" + $($demo.password) + " "
    $primaryInfo = " /s2:" + $($primary.serverInstance) + " /db2:" + $($primary.database) + " /userName2:" + $($primary.user) + " /password2:" + $($primary.password) + " "

    try 
    {
      $exp = ("& '" + $sqlCompareEXE + "'" +  $demoInfo + $primaryInfo +
              " /include:StoredProcedure /include:Table /exclude:Role /exclude:Schema" + 
              " /aow:High /Options:dp2k,nc,ich,icm,icn,ifg,ie,ifg,if,in,inwn,iq,irpt,ip,iup,iu,iw,iweo,ii,it" +
              " /f /report:""" + $outputFolder + "\" + $reportFile +""" /rt:Interactive /rad" +
              " /scriptFile:""" + $scriptFile +"""  ")
              
      Log $exp
      $err = (Invoke-Expression $exp) 2>&1
                   
    }
    catch
    {
        Log "SQL Compare Error: $error"  
    }

    return $scriptFile
}