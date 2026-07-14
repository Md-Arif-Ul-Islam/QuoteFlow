# QuoteFlow – Release Build Script
# Builds the APK and renames the flutter-apk output to quoteflow-release.apk

$appName = "quoteflow"
$flutterApkDir = "$PSScriptRoot\build\app\outputs\flutter-apk"

Write-Host "Building QuoteFlow release APK..." -ForegroundColor Cyan
flutter build apk --release

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed!" -ForegroundColor Red
    exit 1
}

# Rename app-release.apk → quoteflow-release.apk in the flutter-apk folder
$src    = "$flutterApkDir\app-release.apk"
$srcSha = "$flutterApkDir\app-release.apk.sha1"
$dst    = "$flutterApkDir\$appName.apk"
$dstSha = "$flutterApkDir\$appName.apk.sha1"

if (Test-Path $dst)    { Remove-Item $dst    -Force }
if (Test-Path $dstSha) { Remove-Item $dstSha -Force }

if (Test-Path $src)    { Rename-Item $src    -NewName "$appName.apk" }
if (Test-Path $srcSha) { Rename-Item $srcSha -NewName "$appName.apk.sha1" }

Write-Host ""
Write-Host "Done! APK saved as:" -ForegroundColor Green
Write-Host "  $dst" -ForegroundColor Yellow
