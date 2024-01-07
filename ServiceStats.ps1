
foreach ($server in (Get-Content C:\Users\aaravindakshan\Desktop\uat_services.txt )) 
{
if ($server)
{
write-host "`n Server Name: $server `n" -foregroundcolor yellow
Get-Service -ServiceName X* -ComputerName $server
}
}
Read-Host -Prompt “`n `n Press Enter to exit”