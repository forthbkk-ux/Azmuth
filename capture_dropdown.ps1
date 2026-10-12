$dirs = Get-ChildItem -Path "$env:USERPROFILE\Desktop" -Directory
$target = $null
foreach ($d in $dirs) {
    if ($d.Name -ne "AAA" -and (Test-Path (Join-Path $d.FullName "index.html"))) {
        $target = Join-Path $d.FullName "index.html"
        break
    }
}
Write-Output "Found target: $target"
$html = [System.IO.File]::ReadAllText($target, [System.Text.Encoding]::UTF8)
$injectScript = "<script>`nwindow.addEventListener('DOMContentLoaded', () => { setTimeout(() => { toggleCustomDropdown('tambon'); }, 1200); });`n</script>"
$testHtml = $html.Replace('</body>', "$injectScript`n</body>")
[System.IO.File]::WriteAllText('c:\Users\chana\Desktop\AAA\test_dropdown_open.html', $testHtml, [System.Text.Encoding]::UTF8)

Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList "--headless", "--virtual-time-budget=3000", "--window-size=1400,900", "--screenshot=c:\Users\chana\Desktop\AAA\dropdown_open.png", "`"c:\Users\chana\Desktop\AAA\test_dropdown_open.html`"" -Wait
Test-Path "c:\Users\chana\Desktop\AAA\dropdown_open.png"
