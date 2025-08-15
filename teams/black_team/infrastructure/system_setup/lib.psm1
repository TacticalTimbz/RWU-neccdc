function Test-Ping {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,

        [int]$Timeout = 1000  # Timeout in milliseconds, default 1000ms
    )

    $ping = New-Object System.Net.NetworkInformation.Ping
    try {
        $reply = $ping.Send($ComputerName, $Timeout)
        return $reply.Status -eq "Success"
    }
    catch {
        return $false
    }
}

function Watch-Restarts {
    param (
        [CmdletBinding()]
        [string] $NumberOfRestarts,
        [string] $IPAddress
    )
    $initialPing = Test-Ping -ComputerName $IPAddress
    if ( $initialPing -ne  $true ) {
        Write-Warning "Initial ping test was not successful, whack"
        return
    } else {
        $restarts = 0
        Write-Host "Waiting for $NumberOfRestarts Reboot(s) from $IPAddress"
        while ( $NumberOfRestarts -ne $restarts ) {
            $initialUp = 0
            $initialDown = 0
            #Write-Host "Restarts Completed: $restarts" -NoNewline
            #[Console]::SetCursorPosition(0, [Console]::CursorTop)
            while ( (Test-Ping -ComputerName $IPAddress) -eq $true ) { 
                $initialUp = 1
            }

            while ( (Test-Ping -ComputerName $IPAddress) -eq $false) {
                $initialDown = 1
            }

            $cycleUp = Test-Ping -ComputerName $IPAddress

            if ( ($initialUp -eq 1) -and ( $initialDown -eq 1) -and ($cycleUp -eq $true) ) {
                $restarts += 1
            }


        }
        Write-Host "Restarts Completed: $restarts"
    }
}

function Wait-ForWinRM {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ComputerName,
        [int]$TimeoutSeconds = 60,
        [int]$RetryIntervalSeconds = 2,
        [System.Management.Automation.PSCredential] $Credential
    )

    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

    while ($stopwatch.Elapsed.TotalSeconds -lt $TimeoutSeconds) {
        try {
            $session = New-PSSession -ComputerName $ComputerName -Credential $Credential -ErrorAction Stop
            if ($session) {
                Remove-PSSession -Session $session
                Write-Host "WinRM is available on $ComputerName."
                return $true
            }
        }
        catch {
            Write-Host "Waiting for WinRM to come up on $ComputerName"
        }

        Start-Sleep -Seconds $RetryIntervalSeconds
    }

    Write-Warning "WinRM did not become available on $ComputerName within $TimeoutSeconds seconds."
    return $false
}