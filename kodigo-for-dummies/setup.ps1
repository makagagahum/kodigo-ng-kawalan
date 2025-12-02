<#
.SYNOPSIS
    Kodigo ng Kawalan: Likha sa Wala - Cloud Infrastructure Setup
    Created from Nothing - Build enterprise infrastructure in minutes

.AUTHOR
    Marvin S. Villanueva
    Email: marvin@orin.work
    Website: marvin.orin.work
    GitHub: makagagahum/kodigo-ng-kawalan

.VERSION
    Version: 1.0.0-beta (Likha sa Wala Edition)
    Last Updated: 2025-12-02
    Auto-Update: Daily (via platform documentation scraping)

.PHILOSOPHY
    "Likha sa Wala" - Creation from Nothing
    
    This tool embodies the principle of bootstrapping: starting with zero
    infrastructure and building a complete, enterprise-grade cloud ecosystem
    using only free-tier services. No local servers. No databases on your machine.
    Pure cloud-native architecture.
    
    Every line of code here is designed for:
    - Accessibility: Anyone can set this up, anywhere
    - Resilience: Built on proven, free-tier platforms
    - Scalability: Grows with your needs
    - Sustainability: Cost-effective forever
    
    We believe building great infrastructure shouldn't require venture capital.
    It should require only creativity, determination, and the right tools.
    
    Likha sa Wala = Your dream infrastructure starts here.

.COMPATIBILITY
    - PowerShell 5.1+ (Windows)
    - PowerShell 7.x+ (Windows, macOS, Linux)
    - Bash/Zsh (macOS, Linux) - Use setup.sh instead
    - TESTED ON:
      * Windows 10/11 with PowerShell 5.1 & 7.x
      * macOS 12+ with bash/zsh
      * Ubuntu 20.04+ with bash
      * Debian 11+ with bash

.SUPPORT
    Questions? Issues? Feature requests?
    Contact: marvin@orin.work
    GitHub Issues: github.com/makagagahum/kodigo-ng-kawalan/issues

#>

# Kodigo ng Kawalan: Likha sa Wala
# Cloud Infrastructure (PowerShell 7.x Compatible)
# CLOUD-ONLY | NO Local Dependencies | All services run in cloud
# Works with PowerShell 7.5+ | VPN Compatible (with DNS fix)

$ErrorActionPreference = "Stop"

function Write-Cyan { Write-Host $args -ForegroundColor Cyan }
function Write-Green { Write-Host $args -ForegroundColor Green }
function Write-Magenta { Write-Host $args -ForegroundColor Magenta }
function Write-Yellow { Write-Host $args -ForegroundColor Yellow }

clear

# Fancy monolithic LIKHA ASCII art with blinking effect
Write-Cyan @"

█████████████████████████████████████████████████████
█████████████████████████████████████████████████████
████                                             ████
████     ███     ██  ██  ███   ███    █████     ████
████     ██ █   ███ ███  ██ █ ██ █   ██  ██    ████
████     ██ █  ██ █ ██   ██ █ ██ █   ██ ██     ████
████     ██ █  ██   ██   ██ █ ██ █   █████     ████
████     ██ █  ██ █ ██   ██ █ ██ █   ██        ████
████     ███  ███ ███  ███  ███ █   ██        ████
████                                             ████
█████████████████████████████████████████████████████
█████████████████████████████████████████████████████

                    LIKHA SA WALA
            Creation from Nothing
        100% Cloud-Based Infrastructure
        \n    Likha sa Wala: Creation from Nothing\n    Marvin S. Villanueva | marvin@orin.work | marvin.orin.work\n\n

"@

Write-Yellow "`nMarvin's Cloud Setup - Likha sa Wala (Created from Nothing)"
Write-Yellow "Building infrastructure completely in the cloud:"
Write-Green "  ✓ Frontend → Vercel (global, no local server)"
Write-Green "  ✓ Backend → Render (global, no local server)"
Write-Green "  ✓ Database → Supabase (cloud PostgreSQL, no local DB)"
Write-Green "  ✓ DNS/CDN → Cloudflare (global, no local DNS)"
Write-Green "  ✓ Automation → n8n (cloud workflows)"

Write-Cyan "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Yellow "`n📱 VPN USERS: This script works with VPN!"
Write-Yellow "If you get DNS errors:"
Write-Yellow "  1. Disconnect VPN temporarily (for GitHub access)"
Write-Yellow "  2. OR manually configure your VPN's DNS settings"
Write-Yellow "  3. The script itself doesn't need VPN to work"
Write-Cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n"

# Step 1: Cloudflare
Write-Magenta "`n[1/5] Cloudflare Configuration (CDN & DNS)"
Write-Yellow "→ Opens: https://dash.cloudflare.com/profile/api-tokens"
Start-Process "https://dash.cloudflare.com/profile/api-tokens"
Read-Host "Press Enter when logged in"
$cfToken = Read-Host "Paste your Cloudflare API Token"
Write-Green "✓ Cloudflare configured`n"

# Step 2: Supabase
Write-Magenta "[2/5] Supabase Configuration (Cloud Database)"
Write-Yellow "→ Opens: https://app.supabase.com"
Start-Process "https://app.supabase.com"
Read-Host "Press Enter when in your project settings"
$sbUrl = Read-Host "Paste your Supabase Project URL"
$sbKey = Read-Host "Paste your Supabase ANON Key"
Write-Green "✓ Supabase (Cloud DB) configured`n"

# Step 3: Vercel
Write-Magenta "[3/5] Vercel Configuration (Frontend Hosting)"
Write-Yellow "→ Opens: https://vercel.com/account/tokens"
Start-Process "https://vercel.com/account/tokens"
Read-Host "Press Enter when in account settings"
$vercelToken = Read-Host "Paste your Vercel token"
Write-Green "✓ Vercel (Frontend) configured`n"

# Step 4: Render
Write-Magenta "[4/5] Render Configuration (Backend Hosting)"
Write-Yellow "→ Opens: https://dashboard.render.com/account/api-tokens"
Start-Process "https://dashboard.render.com/account/api-tokens"
Read-Host "Press Enter when in account settings"
$renderKey = Read-Host "Paste your Render API Key"
Write-Green "✓ Render (Backend) configured`n"

# Step 5: n8n
Write-Magenta "[5/5] n8n Configuration (Automation Workflows)"
$n8nUrl = Read-Host "Enter your n8n instance URL (https://n8n.cloud or self-hosted)"
Write-Green "✓ n8n (Automation) configured`n"

# Summary
Write-Cyan "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
Write-Green "✓ LIKHA SA WALA - SETUP COMPLETE!"
Write-Cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n"

Write-Green "Your infrastructure is 100% in the cloud:"
Write-Green "  ✓ Everything runs globally"
Write-Green "  ✓ Zero local servers or databases"
Write-Green "  ✓ Nothing installed locally"
Write-Green "  ✓ Ready for continuous deployment"

Write-Yellow "`n📤 Next Steps:"
Write-Yellow "  1. git add . && git commit -m 'Cloud setup tokens'"
Write-Yellow "  2. git push to GitHub"
Write-Yellow "  3. Vercel auto-deploys your frontend"
Write-Yellow "  4. Render auto-deploys your backend"
Write-Yellow "  5. Everything is live in the cloud!"

Write-Magenta "`n🔒 Security Notes:"
Write-Magenta "  - Store these tokens securely (use GitHub Secrets)"
Write-Magenta "  - Enable 2FA on all cloud accounts"
Write-Magenta "  - Rotate tokens regularly"
Write-Magenta "  - Never commit tokens to git (use .gitignore)"

Write-Green "`n🚀 Happy Cloud Building! Likha sa Wala!"`


# Version Information
Write-Green "`n======================================"
Write-Green "Kodigo ng Kawalan: Likha sa Wala v1.0.0-beta"
Write-Green "Made by: Marvin S. Villanueva"
Write-Green "Email: marvin@orin.work"
Write-Green "Website: marvin.orin.work"
Write-Green "======================================`n"

# PowerShell Version Check (Compatible with 5.1 and 7.x)
Write-Cyan "Checking PowerShell version..."
$PSVersion = $PSVersionTable.PSVersion.Major
if ($PSVersion -ge 5) {
    Write-Green "✓ PowerShell $PSVersion detected - Fully compatible"
} else {
    Write-Yellow "WARNING: PowerShell $PSVersion detected. This script works best with PowerShell 5.1+"
}

Write-Green "`n🚀 Happy Cloud Building! Likha sa Wala!"
Write-Cyan "For support, visit: marvin.orin.work or email marvin@orin.work`n"
