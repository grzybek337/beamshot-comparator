# ============================================================
#  Flashlight Comparator - JSON Generator (Main Version)
# ============================================================

# Force PowerShell to use UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# --- CONFIGURATION (EDIT THIS) ---
# 1. Path to the folder on your PC containing your new beamshot images (.jpg)
$SourceFolder = ".\photos" 

# 2. The URL where these images WILL be hosted on your website
$WebUrlPrefix = "https://your-website.com/uploads"
# ---------------------------------

if (-not (Test-Path $SourceFolder)) {
    Write-Host "ERROR: Folder '$SourceFolder' not found." -ForegroundColor Red
    Pause
    exit
}

# 1. Ask for Location Tag
$locationTag = Read-Host "Enter Location Tag (e.g. 'driveway_50m')"
if ([string]::IsNullOrWhiteSpace($locationTag)) { $locationTag = "short" } 

# 2. Find Images
$images = Get-ChildItem -Path $SourceFolder -Include *.jpg, *.jpeg, *.png -Recurse
if ($images.Count -eq 0) { Write-Host "No images found!" -ForegroundColor Red; Pause; exit }

$finalOutput = ""

foreach ($img in $images) {
    $cleanName = $img.BaseName -replace "_", " " -replace "-", " "
    Write-Host "Details for: $cleanName" -ForegroundColor Green
    $lumen = Read-Host "   > Lumens"
    $throw = Read-Host "   > Throw (m)"
    
    # Auto-Calc Candela/Lumen Ratio
    $cdlm = "X"
    if (($lumen -as [double]) -and ($throw -as [double])) {
        try {
            $candela = ([Math]::Pow([double]$throw, 2) * 0.25)
            $cdlm = "{0:N1}" -f ($candela / [double]$lumen)
        } catch { $cdlm = "X" }
    }
    if ([string]::IsNullOrWhiteSpace($lumen)) { $lumen = "X" }
    if ([string]::IsNullOrWhiteSpace($throw)) { $throw = "X" }

    $jsonBlock = @"
    "$($img.BaseName)_$locationTag": {
        name: "$cleanName",
        location: "$locationTag",
        lumen: "$lumen",
        throw: "$throw",
        cdlm: "$cdlm",
        image: "$WebUrlPrefix/$($img.Name)"
    },
"@
    $finalOutput += $jsonBlock + "`n"
}

Clear-Host
Write-Host "COPY THIS CODE INTO YOUR HTML (lightData):" -ForegroundColor Yellow
Write-Host $finalOutput -ForegroundColor White
Pause