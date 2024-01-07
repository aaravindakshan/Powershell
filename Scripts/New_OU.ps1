#Create a new OU

New-ADOrganizationalUnit -Name FL-Sales -Path "DC=NUGGETLAB,DC=COM"

#Create users in the new OU

New-ADUser -Name "User1" -SamAccountName USER1 -Path "OU=FL-SALES,DC=NUGGETLAB,DC=COM"
New-ADUser -Name "User2" -SamAccountName USER2 -Path "OU=FL-SALES,DC=NUGGETLAB,DC=COM"
New-ADUser -Name "User3" -SamAccountName USER3 -Path "OU=FL-SALES,DC=NUGGETLAB,DC=COM"

#Create a new group in the new OU

New-ADGroup -Name "FL-Sales-AcctOp" -SamAccountName FL-Sales-AcctOp -GroupCategory Security -GroupScope DomainLocal -Path "OU=FL-SALES,DC=NUGGETLAB,DC=COM"

#Add users to the group

Add-ADGroupMember FL-Sales-AcctOp USER1,USER2,USER3

#Enumerate the group

Get-ADGroupMember FL-Sales-AcctOp