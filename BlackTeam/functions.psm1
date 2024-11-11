function New-RandomUser {
    $firstNames = Get-Content -Path "$PSScriptRoot\SupportingFiles\first-names.txt"
    $lastNames = Get-Content -Path "$PSScriptRoot\SupportingFiles\last-names.txt"
    
    $firstName = Get-Random -InputObject $firstNames
    $lastName = Get-Random -InputObject $lastNames
    $userName = $firstName.Substring(0, 1) + $lastName  # Example: JSmith
    $displayName = "$firstName $lastName"
    
    return @{ 
        FirstName = $firstName
        LastName = $lastName
        UserName = $userName
        DisplayName = $displayName
    }
}

function New-ADUsers {
    Import-Module ActiveDirectory
    $ou = "OU=Users,$((Get-ADDomain).DistinguishedName)"
    $defaultPassword = "P@ssw0rd!"
    for ($i = 1; $i -le 250; $i++) {
        $userInfo = Generate-RandomUser
        New-ADUser -SamAccountName $userInfo.UserName `
                -UserPrincipalName "$($userInfo.UserName)@domain.com" `
                -GivenName $userInfo.FirstName `
                -Surname $userInfo.LastName `
                -Name $userInfo.DisplayName `
                -DisplayName $userInfo.DisplayName `
                -Path $ou `
                -AccountPassword (ConvertTo-SecureString -AsPlainText $defaultPassword -Force) `
                -Enabled $true `
                -PassThru

        Write-Host "Created user: $($userInfo.UserName)"
    }
    Write-Host "250 user accounts created successfully!"
}