# This script will provide you the disk space from the list of servers mentioned in the text file in html format.
# Author: Arun Aravindakshan Date: 05/07/2022
# This Section is for designing the html page to be created for the output.

$computerleft = $null
$computerright = $null
$strComputer = $null
$colComputers = $null

$a = "<style>"
$a = $a + "BODY{background-color:blue;}alighn:center"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: yellow;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:thistle}"
$a = $a + "TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:palegoldenrod}"
$a = $a + "</style>"


# This Section will get all the servers in Server.txt and list out the drives on them.
$colComputers = get-content "C:\Nuggetlab\Servers.txt"

foreach ($strComputer in $colComputers) 
{
$colDisks = Get-CimInstance Win32_LogicalDisk -computername $strComputer -Filter “DriveType = 3"

foreach ($objdisk in $colDisks)
{
$objdisk = Get-CimInstance Win32_LogicalDisk -computername $strComputer -Filter “DriveType = 3"

#$alltext = $objdisk | Select-Object DeviceID, Size, FreeSpace
$alltext = $objdisk | Select-Object DeviceID, @{Name="Total Size (GB)"; Expression={"{0:N1}" -F ($_.Size/1GB)}}, @{Name="Free Space (GB)"; Expression={"{0:N1}" -F ($_.Freespace/1GB)}}, @{Name="Free Space %"; Expression={"{0:N1}" -F (($_.Freespace/$_.Size)*100)}}
}
$alltext | ConvertTo-Html -head $a -Body $b | Out-File C:\Nuggetlab\drivespace1.htm
$filename = "C:\Nuggetlab\" + $strComputer + ".htm"
$b = "<H2>" + $strComputer +  " Drive Space!</H2>"
$alltext | ConvertTo-Html -head $a -Body $b | Out-File $filename
}


# Below here builds the frames Page based on the number of servers 
# this get the number of Rows needed
#$colComputers
$servercount = $colComputers.count
$serverrows = $servercount/2
$serverrows = [int]$serverrows

$i = 0
$j = $colComputers.count/2

for ($i=0; $i -lt $j; $i++)
{
If ($i -lt 1){$rowpixels = "100"}
If ($i -gt 0){$rowpixels = $rowpixels + ",100"}
}

$serverrowpercentage = 100/$serverrows 

$f = "<html>"
$f = $f + "<frameset cols='50%,50%'>"
$f = $f + "<frameset rows='" + $rowpixels + "'>"

$RT = $colComputers.count/2 + .5
$RT = [int]$RT
$R = 0

foreach ($strComputer in $colComputers)
{

#$test = "COUNT " + $R + "," + $RT
#$test

#Building Left Frames List
If ($R -lt $RT){$computerleft = @($computerleft + $strComputer)}

#Building Right Frames List
If ($R -ge $RT){$computerright = @($computerright + $strComputer)}
$R = $R+1
}



foreach ($strComputer in $computerleft)
{

$f = $f + '<frame src="' +  $strComputer + '.htm" frameborder="1">'
}
$f = $f + "</frameset>"
$f = $f + "<frameset rows='" + $rowpixels + "'>"

foreach ($strComputer in $computerright)
{
$f = $f + '<frame src="' +  $strComputer + '.htm" frameborder="1">'
}
$f = $f + "</frameset>"

$f = $f + "</frameset>"
$f = $f + "</html>"
$f | Out-File C:\Nuggetlab\frames.htm


# select-object | Get-CimInstance -List
#$Computer = Get-CimInstance -Class Win32_ComputerSystem | Select-Object Name
#cls