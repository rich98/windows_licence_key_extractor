$KeyOffset = 52
$Chars = "BCDFGHJKMPQRTVWXY2346789"
$Key = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "DigitalProductId").DigitalProductId
$KeyOutput = ""
for ($i = 28; $i -ge 0; $i--) {
    $Cur = 0
    for ($x = 14; $x -ge 0; $x--) {
        $Cur = $Cur * 256
        $Cur = $Key[$x + $KeyOffset] + $Cur
        $Key[$x + $KeyOffset] = [math]::Floor($Cur / 24)
        $Cur = $Cur % 24
    }
    $KeyOutput = $Chars[$Cur] + $KeyOutput
    if ((29 - $i) % 6 -eq 0 -and $i -ne -1) {
        $i--
        $KeyOutput = "-" + $KeyOutput
    }
}
Write-Host $KeyOutput
