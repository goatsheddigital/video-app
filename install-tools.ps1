# Install-Tools.ps1
# Script to set up a development environment on a new Windows machine
# Requires PowerShell (Run as Administrator)

# Start Script
Write-Host "Starting Development Environment Setup Script..." -ForegroundColor Green

# Step 1: Install Development Tools using Winget
Write-Host "Installing Development Tools using Winget..." -ForegroundColor Yellow
$wingetTools = @(
    "Microsoft.VisualStudioCode",   # Visual Studio Code
    "Git.Git",                      # Git
    "Docker.DockerDesktop",         # Docker Desktop
    "Microsoft.AzureCLI",           # Azure CLI
    "Vim.Vim",                      # Vim
    "JanDeDobbeleer.OhMyPosh"       # Oh My Posh
)

foreach ($tool in $wingetTools) {
    Write-Host "Checking installation for $tool..."
    if (-not (winget list --id $tool -q)) {
        Write-Host "Installing $tool..."
        winget install --id=$tool --accept-source-agreements --accept-package-agreements -e
        Write-Host "$tool installed successfully!" -ForegroundColor Green
    } else {
        Write-Host "$tool is already installed. Skipping..." -ForegroundColor Cyan
    }
}

# Step 2: Install Meslo Nerd Font using Oh My Posh
Write-Host "Installing Meslo Nerd Font for Powerline support..." -ForegroundColor Yellow
oh-my-posh font install
Write-Host "Meslo Nerd Font installed successfully!" -ForegroundColor Green

# Step 3: Configure PowerShell Profile for Oh My Posh and Tools
Write-Host "Configuring PowerShell Profile for Oh My Posh and Tools..." -ForegroundColor Yellow

# Ensure PowerShell profile exists
if (-not (Test-Path -Path $PROFILE)) {
    Write-Host "Creating PowerShell profile..." -ForegroundColor Yellow
    New-Item -ItemType File -Path $PROFILE -Force
}

# Add Oh My Posh initialization to PowerShell profile
$ompInit = 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression'
if (-not (Get-Content $PROFILE | Select-String -Pattern 'oh-my-posh init pwsh')) {
    Add-Content -Path $PROFILE -Value "`n# Initialize Oh My Posh`n$ompInit"
    Write-Host "Oh My Posh initialization added to PowerShell profile." -ForegroundColor Green
} else {
    Write-Host "Oh My Posh is already initialized in PowerShell profile. Skipping..." -ForegroundColor Cyan
}

# Step 4: Ensure Themes Directory Exists
Write-Host "Ensuring Oh My Posh themes directory exists..." -ForegroundColor Yellow
$themesDir = "$HOME\AppData\Local\Programs\oh-my-posh\themes"
if (-not (Test-Path $themesDir)) {
    New-Item -ItemType Directory -Path $themesDir -Force
    Write-Host "Themes directory created: $themesDir" -ForegroundColor Green

    # Download default theme if not present
    Write-Host "Downloading default Oh My Posh theme..." -ForegroundColor Yellow
    $defaultThemeUrl = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/jandedobbeleer.omp.json"
    $themeFilePath = "$themesDir\jandedobbeleer.omp.json"
    Invoke-WebRequest -Uri $defaultThemeUrl -OutFile $themeFilePath
    Write-Host "Default theme downloaded to $themeFilePath" -ForegroundColor Green
} else {
    Write-Host "Themes directory already exists. Ensuring default theme is available..." -ForegroundColor Cyan
    $themeFilePath = "$themesDir\jandedobbeleer.omp.json"
    if (-not (Test-Path $themeFilePath)) {
        Write-Host "Default theme not found. Downloading..." -ForegroundColor Yellow
        $defaultThemeUrl = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/jandedobbeleer.omp.json"
        Invoke-WebRequest -Uri $defaultThemeUrl -OutFile $themeFilePath
        Write-Host "Default theme downloaded to $themeFilePath" -ForegroundColor Green
    } else {
        Write-Host "Default theme already exists. Skipping download." -ForegroundColor Cyan
    }
}

# Step 5: Verify Font and Glyph Rendering
Write-Host "Verifying font and glyph rendering..." -ForegroundColor Yellow
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$testGlyphs = "Checkmark: `u2713, Powerline: `ue0b6, Branch: `ue0a0"
Write-Host $testGlyphs
Write-Host "If glyphs are not rendering correctly, ensure the terminal font is set to 'MesloLGM NF'." -ForegroundColor Red

# Step 6: Add Tools to PATH (if necessary)
Write-Host "Adding tools to PATH..." -ForegroundColor Yellow
$toolsPaths = @(
    "C:\\Program Files\\Vim\\vim90",
    "$HOME\scoop\apps\git\current",
    "$HOME\scoop\apps\oh-my-posh\current"
)

foreach ($path in $toolsPaths) {
    if (-not ($env:PATH -split ';' | ForEach-Object { $_.Trim() } | Where-Object { $_ -eq $path })) {
        $newPath = "$env:PATH;$path"
        [System.Environment]::SetEnvironmentVariable("PATH", $newPath, [System.EnvironmentVariableTarget]::User)
        Write-Host "Added $path to PATH." -ForegroundColor Green
    } else {
        Write-Host "$path is already in PATH. Skipping..." -ForegroundColor Cyan
    }
}

# Step 7: Modify All Users and Admin Profiles
Write-Host "Modifying PowerShell profiles for all users and admin modes..." -ForegroundColor Yellow
$allUsersProfile = "$env:ProgramData\Microsoft\Windows\PowerShell\Profile.ps1"
$adminProfile = "$HOME\Documents\PowerShell\Profile.ps1"

# Add the same configuration to all users and admin profiles
$profilesToModify = @($allUsersProfile, $adminProfile)
foreach ($profilePath in $profilesToModify) {
    if (-not (Test-Path -Path $profilePath)) {
        Write-Host "Creating profile at $profilePath..." -ForegroundColor Yellow
        New-Item -ItemType File -Path $profilePath -Force
    }

    if (-not (Get-Content $profilePath | Select-String -Pattern 'oh-my-posh init pwsh')) {
        Add-Content -Path $profilePath -Value "`n# Initialize Oh My Posh`n$ompInit"
        Write-Host "Added Oh My Posh configuration to $profilePath" -ForegroundColor Green
    } else {
        Write-Host "Profile at $profilePath already configured. Skipping..." -ForegroundColor Cyan
    }
}

# Step 8: Final Instructions
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "Restart your terminal and set the font to 'MesloLGM NF' to ensure proper glyph rendering." -ForegroundColor Yellow
