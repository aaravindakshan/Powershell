$ComputerName = "LAPTOP-7U6BKFO7"
$NumItems = 10
$ReportFile = "C:\Users\Arun A\Desktop\Top10Mem.txt"

param (

        [string]$ComputerName,
        [int]$NumItems,
        [string]$ReportFile

        )

        $ReportData = Get-Process -ComputerName $ComputerName |
                        Sort-Object -Property WS -Descending |
                        Select-Object -First $NumItems

                        if($ReportFile) {
                        $ReportData | Out-File -FilePath $ReportFile }
                        else {
                        Write-Output $ReportData
                        }