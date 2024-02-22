$jsonInputfile = "../../../../output-file.json"
$inputfile = $jsonInputfile
$outputfile = "../../../../OUTPUT.txt"

# Store the txt-file-content in a string
$txtFileContent = Get-Content -Raw $inputfile

function ReplaceBrackets($txtFileContent) {
    $txtFileContent = $txtFileContent -replace '\[', '{' -replace '\]', '}'
    return $txtFileContent
}

function ReplaceIntegersWithStrings($txtFileContent) {
    $txtFileContent = $txtFileContent -replace '(?<!")(\b\d+\b)(?!")', '"$1"'
    return $txtFileContent
}

# Replace integers with strings
$txtFileContent = ReplaceIntegersWithStrings $txtFileContent
# Replace brackets
$txtFileContent = ReplaceBrackets $txtFileContent

# Write to file
$txtFileContent | Out-File $outputfile
