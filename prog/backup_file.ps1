# Relative paths
$inputFileRelative = "../../../input-file.mib.m"
$outputPathRelative = "../prog/backup_data/input-file-backup.mib.m"

# Get the current active directory
$currentDirectory = Get-Location
Write-Host "Current directory $currentDirectory"

# Resolve absolute paths
$inputFile = Resolve-Path -Relative $inputFileRelative
$outputPath = Resolve-Path -Relative $outputPathRelative

# Create the directory if it doesn't exist
$outputDirectory = Split-Path $outputPath -Parent
if (!(Test-Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

Get-Content $inputFile | Out-File $outputPath
Write-Host "Backup of $inputFile has been created at $outputPath."