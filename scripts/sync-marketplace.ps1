$ErrorActionPreference = "Stop"
Set-Location (Split-Path $PSScriptRoot -Parent)

$skillsDir = ".trae\skills"
$marketplacePath = ".claude-plugin\marketplace.json"
$ownerName = "Trae User"
$marketplaceName = "trae-skills-marketplace"

Write-Host "==> Scanning $skillsDir for plugins..." -ForegroundColor Cyan

$plugins = @()

Get-ChildItem -Directory $skillsDir | ForEach-Object {
    $skillDir = $_.FullName
    $pluginJsonPath = Join-Path $skillDir ".claude-plugin\plugin.json"
    
    if (Test-Path $pluginJsonPath) {
        try {
            $plugin = Get-Content $pluginJsonPath -Raw | ConvertFrom-Json
            $entry = @{
                name        = $plugin.name
                source      = "./$skillsDir/$($_.Name)"
                description = $plugin.description
                version     = $plugin.version
                category    = if ($plugin.category) { $plugin.category } else { "general" }
                keywords    = if ($plugin.keywords) { @($plugin.keywords) } else { @() }
            }
            $plugins += $entry
            Write-Host "  + $($plugin.name)" -ForegroundColor Green
        }
        catch {
            Write-Warning "  ! Failed to parse $pluginJsonPath : $_"
        }
    }
    else {
        Write-Host "  - $($_.Name)  (no .claude-plugin/plugin.json, skipping)" -ForegroundColor DarkGray
    }
}

$marketplace = @{
    '$schema' = "https://code.claude.com/schemas/marketplace.json"
    name      = $marketplaceName
    owner     = @{
        name = $ownerName
    }
    description = "Local marketplace for Trae AI skills"
    metadata    = @{
        pluginRoot = $skillsDir
    }
    plugins     = @($plugins)
}

$json = $marketplace | ConvertTo-Json -Depth 5

# pretty-print with intelligent indentation (2-space)
$sb = [System.Text.StringBuilder]::new()
$indent = 0
foreach ($ch in $json.ToCharArray()) {
    $c = $ch.ToString()
    if ($c -eq '{' -or $c -eq '[') {
        [void]$sb.Append($c); [void]$sb.AppendLine()
        $indent += 2
        [void]$sb.Append(' ' * $indent)
    }
    elseif ($c -eq '}' -or $c -eq ']') {
        [void]$sb.AppendLine()
        $indent -= 2
        [void]$sb.Append(' ' * $indent); [void]$sb.Append($c)
    }
    elseif ($c -eq ',') {
        [void]$sb.Append($c); [void]$sb.AppendLine()
        [void]$sb.Append(' ' * $indent)
    }
    else {
        [void]$sb.Append($c)
    }
}
$prettyJson = $sb.ToString().TrimEnd() + "`n"

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $marketplacePath), $prettyJson, $utf8NoBom)
Write-Host "`n==> marketplace.json updated with $($plugins.Count) plugin(s)" -ForegroundColor Cyan