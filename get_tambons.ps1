$data = Import-Csv -Path 'c:\Users\chana\Desktop\AAA\sheet_corrected.csv' -Encoding utf8
$pCol = ($data[0].psobject.properties.Name | Where-Object { $_ -like '*หวัด*' })[0]
$dCol = ($data[0].psobject.properties.Name | Where-Object { $_ -like '*เภอ*' })[0]
$tCol = ($data[0].psobject.properties.Name | Where-Object { $_ -like '*บล*' })[0]

$groups = $data | Group-Object $pCol, $dCol, $tCol
$list = New-Object System.Collections.Generic.List[string]

foreach ($g in $groups) {
    $line = $g.Values[0] + ',' + $g.Values[1] + ',' + $g.Values[2] + ',' + $g.Count
    $list.Add($line)
}

[System.IO.File]::WriteAllLines('c:\Users\chana\Desktop\AAA\tambons_out.txt', $list, [System.Text.Encoding]::UTF8)
Write-Output "FINISHED"
