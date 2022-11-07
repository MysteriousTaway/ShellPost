function  ConnectToSQLServer {
    param (
        [Parameter(Mandatory=$true)] [String]$ServerName,
        [Parameter(Mandatory=$true)] [String]$DatabaseName,
        [Parameter(Mandatory=$true)] [String]$UserName,
        [Parameter(Mandatory=$true)] [String]$Password
    )
    Write-Host "[DEBUG: SQLManager, ConnectToSQLServer] Connecting to SQL Server" -ForegroundColor Yellow
    try {
        $connectionString = "Server=$ServerName;Database=$DatabaseName;User Id=$UserName;Password=$Password;"
        $connection = New-Object System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = $connectionString
        $connection.Open()
        return $connection
    } catch {
        Write-Host "[ERROR: SQLManager, ConnectToSQLServer] Failed to connect to SQL Server ` " $_ -ForegroundColor Red
    }
}

Export-ModuleMember -Function ConnectToSQLServer