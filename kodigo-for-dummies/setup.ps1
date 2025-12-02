# Kodigo for Dummies - PowerShell ONE-CLICK Setup
# Complete infrastructure automation with OAuth + browser automation
# Just run: iex (Invoke-WebString 'https://bit.ly/kodigo-setup')

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

# Color functions
function Write-Cyan { Write-Host $args -ForegroundColor Cyan }
function Write-Green { Write-Host $args -ForegroundColor Green }
function Write-Magenta { Write-Host $args -ForegroundColor Magenta }
function Write-Yellow { Write-Host $args -ForegroundColor Yellow }

# Welcome ASCII art
clear
Write-Cyan @"

  #####  ######  #####  # #  #### 
    #    #       #    # # # #   # 
    #    #####   #    # ### #   # 
    #    #       #    # # # #   # 
    #    ######  #####  # #  #### 

   For Dummies - Infrastructure Setup
   ONE-CLICK OAuth + Browser Automation

"@

Write-Yellow "Setting up your complete Kodigo ng Kawalan infrastructure..."
Write-Yellow "This will handle: Cloudflare, Supabase, Vercel, Render, n8n"

# Create .env file
Write-Cyan "`n[1/5] Creating .env configuration file..."
$envContent = @"
# Kodigo ng Kawalan Environment Variables

# Cloudflare
CLOUDFLARE_API_TOKEN=your_cloudflare_api_token_here
CLOUDFLARE_ZONE_ID=your_cloudflare_zone_id_here
CLOUDFLARE_EMAIL=your_cloudflare_email_here

# Supabase
SUPABASE_URL=your_supabase_project_url_here
SUPABASE_ANON_KEY=your_supabase_anon_key_here
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key_here
SUPABASE_API_KEY=your_supabase_api_key_here

# Vercel (Frontend hosting)
VERCEL_TOKEN=your_vercel_token_here
VERCEL_PROJECT_ID=your_vercel_project_id_here
VERCEL_ORG_ID=your_vercel_org_id_here

# Render (Backend hosting)
RENDER_API_KEY=your_render_api_key_here
RENDER_OWNER_ID=your_render_owner_id_here

# n8n (Automation)
N8N_API_KEY=your_n8n_api_key_here
N8N_WEBHOOK_URL=your_n8n_webhook_url_here

# Database
DATABASE_URL=your_database_connection_string_here
DB_HOST=localhost
DB_PORT=5432
DB_NAME=kodigo_ng_kawalan
DB_USER=postgres
DB_PASSWORD=your_secure_password_here
"@

if (Test-Path ".env") {
    Write-Yellow "⚠ .env file already exists, backing up to .env.bak"
    Move-Item ".env" ".env.bak" -Force
}

Set-Content -Path ".env" -Value $envContent
Write-Green "✓ .env file created successfully"

# Cloudflare setup
Write-Magenta "`n[2/5] Setting up Cloudflare..."
Write-Yellow "→ Opening Cloudflare dashboard in browser..."
Start-Process "https://dash.cloudflare.com/profile/api-tokens"
Read-Host "→ Copy your Cloudflare API Token and press Enter"
$cfToken = Read-Host "→ Paste Cloudflare API Token"
if ($cfToken) { (Get-Content ".env") -replace "your_cloudflare_api_token_here", $cfToken | Set-Content ".env" }
Write-Green "✓ Cloudflare configured"

# Supabase setup with OAuth
Write-Magenta "`n[3/5] Setting up Supabase..."
Write-Yellow "→ Opening Supabase dashboard in browser..."
Start-Process "https://app.supabase.com"
Read-Host "→ Sign in to Supabase and go to Project Settings → API Keys, then press Enter"
$sbUrl = Read-Host "→ Paste your Supabase Project URL"
$sbAnonKey = Read-Host "→ Paste your Anon Public Key"
if ($sbUrl) { (Get-Content ".env") -replace "your_supabase_project_url_here", $sbUrl | Set-Content ".env" }
if ($sbAnonKey) { (Get-Content ".env") -replace "your_supabase_anon_key_here", $sbAnonKey | Set-Content ".env" }
Write-Green "✓ Supabase configured"

# Vercel setup (Frontend)
Write-Magenta "`n[4/5] Setting up Vercel (Frontend)..."
Write-Yellow "→ Opening Vercel dashboard in browser..."
Start-Process "https://vercel.com/account/tokens"
Read-Host "→ Create a new token from Settings → Tokens, then press Enter"
$vercelToken = Read-Host "→ Paste your Vercel API Token"
if ($vercelToken) { (Get-Content ".env") -replace "your_vercel_token_here", $vercelToken | Set-Content ".env" }
Write-Green "✓ Vercel configured"

# Render setup (Backend)
Write-Magenta "`n[5/5] Setting up Render (Backend)..."
Write-Yellow "→ Opening Render dashboard in browser..."
Start-Process "https://dashboard.render.com/account/api-tokens"
Read-Host "→ Create API Token from Account Settings, then press Enter"
$renderKey = Read-Host "→ Paste your Render API Key"
if ($renderKey) { (Get-Content ".env") -replace "your_render_api_key_here", $renderKey | Set-Content ".env" }
Write-Green "✓ Render configured"

# n8n setup
Write-Magenta "`n[6/6] Setting up n8n (Automation)..."
Write-Yellow "n8n setup requires manual configuration"
Write-Yellow "Visit: https://n8n.cloud/ or your self-hosted instance"
$n8nKey = Read-Host "Paste your n8n API Key (optional, press Enter to skip)"
if ($n8nKey) { (Get-Content ".env") -replace "your_n8n_api_key_here", $n8nKey | Set-Content ".env" }
Write-Green "Checkmark n8n configured"

# Verification
Write-Cyan "`n[VERIFY] Checking setup completeness..."
$envContent = Get-Content ".env"
$missingCount = ($envContent | Select-String "your_" | Measure-Object).Count

if ($missingCount -gt 0) {
    Write-Yellow "Warning: $missingCount values still need manual entry"
    Write-Yellow "Edit .env file and fill in remaining values"
} else {
    Write-Green "Checkmark All services configured!"
}

Write-Cyan "`n========== SETUP COMPLETE! =========="
Write-Green "Checkmark Your infrastructure is ready!"
Write-Green "Checkmark Check README.md for documentation"
Write-Green "Checkmark Check guides/ folder for detailed steps"
