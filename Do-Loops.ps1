
# help topic
Get-Help about_Do

# syntax
do {
    
} while (condition)

do {
    
} until (condition)


$machine = "SQL-NUG"

# loop while a condition is true
do {
    Write-Host "$machine is online!" -ForegroundColor Green
    Start-Sleep -Seconds 3
} while (Test-Connection $machine -Quiet -Count 1)

Write-Host "$machine is offline..." -ForegroundColor Red

# loop until a condition is true
do {
    Write-Host "$machine is offline..." -ForegroundColor Red
    Start-Sleep -Seconds 3
} until (Test-Connection $machine -Quiet -Count 1)

Write-Host "$machine is online!" -ForegroundColor Green