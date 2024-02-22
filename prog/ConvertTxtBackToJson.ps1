Write-Host "starting convertbacktojson"

$inputFile = "../../../../OUTPUT.txt"
$outputPath = "../../../../output-file.json"

Get-Content $inputFile | Out-File $outputPath
# Get-Item $inputfile | Remove-Item

Write-Host "Converted input-file.mib JSON"
