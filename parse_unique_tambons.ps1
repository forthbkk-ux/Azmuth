$lines = [System.IO.File]::ReadAllLines('c:\Users\chana\Desktop\AAA\sheet_corrected.csv', [System.Text.Encoding]::UTF8)
$set = New-Object 'System.Collections.Generic.HashSet[string]'
for ($i = 1; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    $parts = $line.Split(',')
    if ($parts.Length -ge 5) {
        $tambon = $parts[2].Trim()
        $amphoe = $parts[3].Trim()
        $changwat = $parts[4].Trim()
        $key = "$changwat|$amphoe|$tambon"
        [void]$set.Add($key)
    }
}

$sorted = [System.Linq.Enumerable]::ToList($set)
$sorted.Sort()
[System.IO.File]::WriteAllLines('c:\Users\chana\Desktop\AAA\tambons_unique.txt', $sorted, [System.Text.Encoding]::UTF8)
Write-Output "Unique count: $($sorted.Count)"
