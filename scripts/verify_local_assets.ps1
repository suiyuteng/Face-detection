# Read-only verifier for private local files.
# Copy catalog/local_paths.template.csv to catalog/local_paths.csv, then fill local paths.
param(
    [string]$Manifest = (Join-Path $PSScriptRoot '..\catalog\local_paths.csv'),
    [string]$Report = (Join-Path $PSScriptRoot '..\artifacts\local_hash_report.csv')
)

if (-not (Test-Path -LiteralPath $Manifest -PathType Leaf)) {
    throw "Manifest not found: $Manifest. Copy catalog/local_paths.template.csv first."
}

$rows = @(Import-Csv -LiteralPath $Manifest)
if ($rows.Count -eq 0) { throw "Manifest is empty." }
$reportRows = foreach ($item in $rows) {
    $filePath = [string]$item.path
    $expected = ([string]$item.expected_sha256).Trim().ToLowerInvariant()
    $result = [ordered]@{
        id = [string]$item.id
        path = $filePath
        status = 'unmapped'
        size_bytes = ''
        sha256 = ''
        matches_expected = ''
    }
    if ([string]::IsNullOrWhiteSpace($filePath)) {
        [PSCustomObject]$result
        continue
    }
    try {
        $file = Get-Item -LiteralPath $filePath -ErrorAction Stop
        if ($file.PSIsContainer) { throw "Not a file" }
        $sha = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256 -ErrorAction Stop).Hash.ToLowerInvariant()
        $result.status = 'ok'
        $result.size_bytes = [string]$file.Length
        $result.sha256 = $sha
        if ($expected.Length -gt 0) {
            $result.matches_expected = [string]($sha -eq $expected)
        }
    }
    catch {
        $result.status = "error: $($_.Exception.Message)"
    }
    [PSCustomObject]$result
}
$parent = Split-Path -Parent $Report
if (-not (Test-Path -LiteralPath $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
}
$reportRows | Export-Csv -LiteralPath $Report -NoTypeInformation -Encoding UTF8
Write-Host "Checked $($reportRows.Count) manifest entries. Report: $Report"
Write-Host 'Original files were not modified, moved, or deleted.'
