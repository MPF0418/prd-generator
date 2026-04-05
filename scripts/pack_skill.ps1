# PRD Generator Skill Package Script
# 用于打包 prd-generator skill

$ErrorActionPreference = "Stop"

$skillName = "prd-generator"
$skillPath = "C:\Users\Administrator\.codebuddy\skills\$skillName"

Write-Host "Packaging skill: $skillName" -ForegroundColor Cyan
Write-Host "Skill path: $skillPath" -ForegroundColor Gray

# 检查目录是否存在
if (-not (Test-Path $skillPath)) {
    Write-Error "Skill directory not found: $skillPath"
    exit 1
}

# 检查SKILL.md是否存在
if (-not (Test-Path "$skillPath\SKILL.md")) {
    Write-Error "SKILL.md not found in $skillPath"
    exit 1
}

# 列出skill内容
Write-Host "`nSkill contents:" -ForegroundColor Green
Get-ChildItem $skillPath -Recurse | ForEach-Object {
    $relativePath = $_.FullName.Replace($skillPath, "").TrimStart("\")
    $size = if (-not $_.PSIsContainer) { "($([math]::Round($_.Length / 1KB, 1)) KB)" } else { "(dir)" }
    Write-Host "  $relativePath $size" -ForegroundColor Gray
}

Write-Host "`nSkill '$skillName' is ready!" -ForegroundColor Green
Write-Host "Location: $skillPath" -ForegroundColor Cyan
