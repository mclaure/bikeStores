# Execute-DemoQuery: Executes a Query in Demo Server
# returns: void
Function Invoke-DemoQuery 
{
    Param
    (
        [Parameter(Position=0,Mandatory=$true)][string] $query,
        [Parameter(Position=1,Mandatory=$false)][string] $database        
    )

    $demo = $credentials.demo
    $database = if($database) { $database } else { $demo.database }

    try 
    {
        Invoke-Sqlcmd -Query $query -ServerInstance $demo.serverInstance -Database $database -UserName $demo.user -Password $demo.password 
    }
    catch
    {
        Log "Error: $error"
    }
}

# Execute-DemoScript: Executes an Script in Demo Server
# returns: void
Function Invoke-DemoScript 
{
    Param
    (
        [Parameter(Position=0,Mandatory=$true)][string] $pathFile
    )

    $demo = $credentials.demo

    try 
    {
        Invoke-Sqlcmd -Input $pathFile -ServerInstance $demo.serverInstance -Database $demo.database -UserName $demo.user -Password $demo.password 
    }
    catch
    {
       Log "Error: $error"
    }
}

# Execute-PrimaryScript: Executes an Script on Primary Server
# returns: void
Function Invoke-PrimaryScript 
{
    Param
    (
        [Parameter(Position=0,Mandatory=$true)][string] $pathFile
    )

    $primary = $credentials.primary

    try 
    {
        Invoke-Sqlcmd -Input $pathFile -ServerInstance $primary.serverInstance -Database $primary.database -UserName $primary.user -Password $primary.password 
    }
    catch
    {
       Log "Invoke-PrimaryScript Error: $error"
    }
}

# Execute-PrimaryScript: Executes an Script on Secondary Server
# returns: void
Function Invoke-SecondaryScript 
{
    Param
    (
        [Parameter(Position=0,Mandatory=$true)][string] $pathFile
    )

    $secondary = $credentials.secondary

    try 
    {
        Invoke-Sqlcmd -Input $pathFile -ServerInstance $secondary.serverInstance -Database $secondary.database -UserName $secondary.user -Password $secondary.password 
    }
    catch
    {
       Log "Invoke-SecondaryScript Error: $error"
    }
}