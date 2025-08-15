Import-Module -Name "$PSScriptRoot\..\..\lib.psm1"
function New-DomainController {
    param (
        [CmdletBinding()]
        [string] $IPAddress,
        [string] $HostName,
        [string] $DomainName
    )
    $username = "Administrator"
    $securePassword = ConvertTo-SecureString "qwerty12345!@#$%" -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)
    Wait-ForWinRM -ComputerName $IPAddress -TimeoutSeconds 300 -Credential $credential
    $session = New-PSSession -ComputerName $IPAddress -Credential $credential
    $installADDomainServices = Invoke-Command -Session $session -ScriptBlock { Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools }
    Invoke-Command -Session $session -ScriptBlock { Rename-Computer -NewName "hihihi" -Restart }
    Watch-Restarts -NumberOfRestarts 1 -IPAddress $IPAddress
    # if ( $installADDomainServices.Success -eq $true ) {
    #     $installForest = Invoke-Command -Session $session -ScriptBlock { Install-ADDSForest -DomainName $using:DomainName -InstallDns }
    #     if ( $installForest.Status -eq "Error") {
    #         Write-Warning "Unable to install forest error error error stupid computers"
    #         return
    #     } else {
    #         Watch-Restarts -NumberOfRestarts 1 -IPAddress $IPAddress
    #     }
    # } else {
    #     Write-Host "Whack"
    # }
    Remove-PSSession $session
}