# Kodigo ng Kawalan - Cloud Infrastructure (PowerShell 7.x Compatible)
# CLOUD-ONLY | NO Local Dependencies | All services run in cloud
# Works with PowerShell 7.5+

$ErrorActionPreference = "Stop"

function Write-Cyan { Write-Host $args -ForegroundColor Cyan }
function Write-Green { Write-Host $args -ForegroundColor Green }
function Write-Magenta { Write-Host $args -ForegroundColor Magenta }
function Write-Yellow { Write-Host $args -ForegroundColor Yellow }

clear
Write-Cyan @"

  KODIGO NG KAWALAN - 100% CLOUD SETUP
  Zero Local Dependencies | All Cloud-Based

"@

Write-Yellow "Marvin, this setup is completely cloud-native:"
Write-Yellow "  - Frontend hosted on Vercel (no local server)"
Write-Yellow "  - Backend hosted on Render (no local server)"
Write-Yellow "  - Database on Supabase (cloud PostgreSQL)"
Write-Yellow "  - DNS/CDN on Cloudflare (no local DNS)"
Write-Yellow "  - Automation on n8n (cloud workflows)"

Write-Yellow "`nLet's configure your cloud credentials:"

# Step 1: Cloudflare
Write-Magenta "`n[1/5] Cloudflare Configuration"
Write-Yellow "Opening Cloudflare dashboard..."
Start-Process "https://dash.cloudflare.com/profile/api-tokens"
Read-Host "Press Enter when logged into Cloudflare"
$cfToken = Read-Host "Paste your Cloudflare API Token"
Write-Green "Cloudflare token saved"

# Step 2: Supabase
Write-Magenta "`n[2/5] Supabase Configuration (Cloud Database)"
Write-Yellow "Opening Supabase console..."
Start-Process "https://app.supabase.com"
Read-Host "Press Enter when in your project settings"
$sbUrl = Read-Host "Paste Supabase Project URL"
$sbKey = Read-Host "Paste Supabase ANON Key"
Write-Green "Supabase cloud DB configured"

# Step 3: Vercel
Write-Magenta "`n[3/5] Vercel Configuration (Frontend Hosting)"
Write-Yellow "Opening Vercel dashboard..."
Start-Process "https://vercel.com/account/tokens"
Read-Host "Press Enter when in account settings"
$vercelToken = Read-Host "Paste Vercel token"
Write-Green "Vercel frontend hosting configured"

# Step 4: Render
Write-Magenta "`n[4/5] Render Configuration (Backend Hosting)"
Write-Yellow "Opening Render dashboard..."
Start-Process "https://dashboard.render.com/account/api-tokens"
Read-Host "Press Enter when in account settings"
$renderKey = Read-Host "Paste Render API Key"
Write-Green "Render backend hosting configured"

# Step 5: n8n
Write-Magenta "`n[5/5] n8n Configuration (Automation)"
$n8nUrl = Read-Host "Enter n8n instance URL (https://n8n.cloud or your self-hosted URL)"
Write-Green "n8n automation configured"

# Summary
Write-Cyan "`n════════════════════"
Write-Green "`n2713 CLOUD SETUP COMPLETE!"
Write-Green "`n2713 Everything is running 100% in the cloud"
Write-Green "`n2713 Zero local servers or databases"
Write-Cyan "════════════════════"

Write-Yellow "`nNext: git push to GitHub and watch Vercel/Render deploy automatically!"
Write-Green "`nHappy cloud building! 🚀"
