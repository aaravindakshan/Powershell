### Managed Service Accounts (MSA) ###

# Create a managed service account

New-ADServiceAccount -Name MSA-nugsrv -RestrictToSingleComputer


Add-ADComputerServiceAccount -Identity DC-NUG1 -ServiceAccount MSA-nugsrv

Test-ADServiceAccount -Identity MSA-nugsrv



# Install MSA on local DC-NUG1


Install-ADServiceAccount MSA-nugsrv

Test-ADServiceAccount -Identity MSA-nugsrv


# Create a dummy service

New-Service -Name NUGSRV -BinaryPathName c:\windows\system32\notepad.exe



### Group Managed Service Accounts (GMSA) ###


# create key distribution center root key


Add-KDSRootKey -EffectiveTime (Get-Date).AddHours((-10))



# Create a group managed service account


New-ADServiceAccount -Name GMSA-nugsrv -DNSHostName GMSA-nugsrv.nuggetlab.com -PrincipalsAllowedToRetrieveManagedPassword "Domain Computers"

Invoke-Command -ComputerName APP-NUG -ScriptBlock { Install-WindowsFeature RSAT-AD-PowerShell }

# Install the gMSA

Install-ADServiceAccount GMSA-nugsrv

Test-ADServiceAccount -Identity GMSA-nugsrv

# Create a dummy service

New-Service -Name NUGSRV -BinaryPathName c:\windows\system32\notepad.exe
