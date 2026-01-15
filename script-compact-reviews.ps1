# ============================================================
#  Flashlight Comparator - JSON Generator (Compact Version, for reviews)
# ============================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# --- CONFIGURATION (EDIT THIS) ---
$SourceFolder = ".\photos" 
$WebUrlPrefix = "https://your-website.com/uploads"
# ---------------------------------

if (-not (Test-Path $SourceFolder)) {
    Write-Host "ERROR: Folder '$SourceFolder' not found." -ForegroundColor Red
    Pause
    exit
}

$images = Get-ChildItem -Path $SourceFolder -Include *.jpg, *.jpeg, *.png -Recurse
if ($images.Count -eq 0) { Write-Host "No images found!" -ForegroundColor Red; Pause; exit }

$finalOutput = ""

foreach ($img in $images) {
    $cleanName = $img.BaseName -replace "_", " " -replace "-", " "
    Write-Host "Processed: $cleanName" -ForegroundColor Green
    
    $jsonBlock = @"
    "$($img.BaseName)": {
        name: "$cleanName",
        image: "$WebUrlPrefix/$($img.Name)"
    },
"@
    $finalOutput += $jsonBlock + "`n"
}

Clear-Host
Write-Host "COPY THIS CODE INTO YOUR HTML (lightData):" -ForegroundColor Yellow
Write-Host $finalOutput -ForegroundColor White
Pause