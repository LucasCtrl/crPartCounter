<#
.SYNOPSIS
    Sums the part quantities (SUM1, 7th field) of Cut Rite .ptn files dated within a timeframe.
.EXAMPLE
    .\crPartCounter.ps1 -Path C:\CutRite\Data -Year 2026
    .\crPartCounter.ps1 -Path C:\CutRite\Data -StartDate 01/03/2026
    .\crPartCounter.ps1 -Path C:\CutRite\Data -StartDate 01/03/2026 -EndDate 30/06/2026
#>
param(
    [Parameter(Mandatory)][string]$Path,
    [string]$Year,
    [string]$StartDate,
    [string]$EndDate
)

$ErrorActionPreference = 'Stop'
$culture = [Globalization.CultureInfo]::InvariantCulture

function ConvertTo-Date([string]$s) {
    [datetime]::ParseExact($s, 'dd/MM/yyyy', $culture)
}

if ($Year -and -not $StartDate -and -not $EndDate) {
    if ($Year -notmatch '^\d{4}$') { throw "Bad year '$Year', expected YYYY." }
    $from = [datetime]::new([int]$Year, 1, 1)
    $to = [datetime]::new([int]$Year, 12, 31)
} elseif ($StartDate -and -not $Year -and -not $EndDate) {
    $from = ConvertTo-Date $StartDate
    $to = (Get-Date).Date
} elseif ($StartDate -and $EndDate -and -not $Year) {
    $from = ConvertTo-Date $StartDate
    $to = ConvertTo-Date $EndDate
} else {
    throw 'Bad arguments: use -Year, or -StartDate, or -StartDate with -EndDate.'
}

if (-not (Test-Path -LiteralPath $Path -PathType Container)) { throw "Folder not found: $Path" }

$total = 0
$fileCount = 0
foreach ($file in Get-ChildItem -LiteralPath $Path -Filter *.ptn -File) {
    $lines = Get-Content -LiteralPath $file.FullName
    # REV1,1,17/06/26 09:31,USER,1 -> date is the 3rd field
    $rev = $lines | Where-Object { $_ -like 'REV1,*' } | Select-Object -First 1
    if (-not $rev) { Write-Warning "$($file.Name): no REV1 line, skipped."; continue }
    $date = [datetime]::ParseExact(($rev -split ',')[2], 'dd/MM/yy HH:mm', $culture).Date
    if ($date -lt $from -or $date -gt $to) { continue }

    $sum = $lines | Where-Object { $_ -like 'SUM1,*' } | Select-Object -First 1
    if (-not $sum) { Write-Warning "$($file.Name): no SUM1 line, skipped."; continue }
    $qty = [int](($sum -split ',')[6])
    Write-Verbose "$($file.Name) $($date.ToString('dd/MM/yyyy')) : $qty"
    $total += $qty
    $fileCount++
}

Write-Output "Period $($from.ToString('dd/MM/yyyy')) - $($to.ToString('dd/MM/yyyy')): $fileCount file(s), $total part(s)"
