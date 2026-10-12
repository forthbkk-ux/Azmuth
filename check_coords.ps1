$lines = [System.IO.File]::ReadAllLines('c:\Users\chana\Desktop\AAA\sheet_corrected.csv', [System.Text.Encoding]::UTF8)

# Group villages by tambon and print min/max lat/lng
$dict = @{}
for ($i = 1; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    $parts = $line.Split(',')
    if ($parts.Length -ge 7) {
        $t = $parts[2].Trim()
        $a = $parts[3].Trim()
        $p = $parts[4].Trim()
        $lat = [double]::Parse($parts[5].Trim())
        $lng = [double]::Parse($parts[6].Trim())
        $key = "$p|$a|$t"
        if (-not $dict.ContainsKey($key)) {
            $dict[$key] = New-Object System.Collections.Generic.List[psobject]
        }
        $dict[$key].Add([PSCustomObject]@{ Lat = $lat; Lng = $lng; Name = $parts[1] })
    }
}

$outLines = New-Object System.Collections.Generic.List[string]
foreach ($k in ($dict.Keys | Sort-Object)) {
    $pts = $dict[$k]
    $avgLat = ($pts | Measure-Object -Property Lat -Average).Average
    $avgLng = ($pts | Measure-Object -Property Lng -Average).Average
    $outLines.Add(("{0} : count={1}, lat={2:F4}, lng={3:F4}" -f $k, $pts.Count, $avgLat, $avgLng))
}

[System.IO.File]::WriteAllLines('c:\Users\chana\Desktop\AAA\tambon_coords.txt', $outLines, [System.Text.Encoding]::UTF8)
Write-Output "Written $($dict.Count) tambons"
