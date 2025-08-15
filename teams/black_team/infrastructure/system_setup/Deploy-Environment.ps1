Get-ChildItem -Path "$PSScriptRoot\services\windows" -Recurse -File -Include "*.psm1" | ForEach-Object { Import-Module -Name $_.FullName -Force }
Import-Module -Name "$PSScriptRoot\lib.psm1" -Force
############################## ----- Infrastructure ----- ##############################

# Start Terraform
terraform -chdir="$PSScriptRoot\terraform" apply -auto-approve

While ( ! ( Test-Ping -ComputerName "172.16.128.100" ) ) {
    Write-Host "Waiting for IP Addresses to be applied"
}

# Initial reboot after proxmox restarts to apply IP Addresses
Watch-Restarts -NumberOfRestarts 1 -IPAddress "172.16.128.100"

############################## ----- Domain Controller ----- ##############################

New-DomainController -IPAddress "172.16.128.100" -HostName "yeet" -DomainName "Test"

# Connect to the machine