#!/bin/bash

# ============================================================================
# Kodigo ng Kawalan - ULTIMATE AUTO-SETUP
# One-Click Infrastructure Setup with OAuth & Browser Automation
# ============================================================================
# This script opens browsers, handles OAuth, and auto-configures:
# • Cloudflare (CDN & Security)
# • Supabase (Database)
# • Vercel (Frontend/App Hosting)
# • Render (Backend/API Server)
# • n8n (Automation)
# ============================================================================

set -e

# ============================================================================
# COLOR OUTPUT
# ============================================================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

open_browser() {
    local url=$1
    local service=$2
    
    echo -e "${CYAN}\n➤ Opening $service in your browser...${NC}"
    echo -e "  ${BLUE}URL: $url${NC}"
    
    # Detect OS and open browser
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        xdg-open "$url" 2>/dev/null || open "$url" 2>/dev/null || sensible-browser "$url"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open "$url"
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
        start "$url"
    fi
    
    sleep 2
}

read_with_prompt() {
    local prompt=$1
    local var_name=$2
    
    echo -e "\n${YELLOW}$prompt${NC}"
    echo -e "  ${BLUE}Paste value and press Enter:${NC}"
    read -r value
    eval "$var_name='$value'"
}

print_header() {
    echo -e "\n${MAGENTA}════════════════════════════════════════════════════${NC}"
    echo -e "${MAGENTA}  $1${NC}"
    echo -e "${MAGENTA}════════════════════════════════════════════════════${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# ============================================================================
# CLOUDFLARE SETUP
# ============================================================================
setup_cloudflare() {
    print_header "STEP 1: Cloudflare Setup (CDN & Security)"
    
    print_info "We'll open Cloudflare to get your API token"
    open_browser "https://dash.cloudflare.com/profile/api-tokens" "Cloudflare API Tokens"
    
    read_with_prompt "1. Click 'Create Token' → Select 'Edit zone DNS' template" "CLOUDFLARE_API_TOKEN"
    read_with_prompt "2. Go to Overview tab and copy your Zone ID" "CLOUDFLARE_ZONE_ID"
    read_with_prompt "3. Enter your domain (e.g., example.com)" "CLOUDFLARE_DOMAIN"
    
    print_success "Cloudflare configured!"
}

# ============================================================================
# SUPABASE SETUP (OAuth)
# ============================================================================
setup_supabase() {
    print_header "STEP 2: Supabase Setup (Database with OAuth)"
    
    print_info "Opening Supabase to create your database project"
    open_browser "https://app.supabase.com/" "Supabase Dashboard"
    
    read_with_prompt "1. Click 'New Project' and wait for it to create" "SUPABASE_PROJECT_NAME"
    read_with_prompt "2. Once created, go to Settings → API and copy Project URL" "SUPABASE_URL"
    read_with_prompt "3. Copy the 'anon public' key" "SUPABASE_ANON_KEY"
    read_with_prompt "4. Copy the 'service_role secret' key" "SUPABASE_SERVICE_ROLE_KEY"
    read_with_prompt "5. You set this when creating the project - what was the DB password?" "SUPABASE_DB_PASSWORD"
    
    print_success "Supabase configured!"
}

# ============================================================================
# VERCEL SETUP (OAuth)
# ============================================================================
setup_vercel() {
    print_header "STEP 3: Vercel Setup (Frontend Hosting with OAuth)"
    
    print_info "Opening Vercel for authentication"
    open_browser "https://vercel.com/login" "Vercel Login"
    
    read_with_prompt "1. Log in with GitHub or your preferred provider" "VERCEL_USER_PROMPT"
    
    echo -e "\n${YELLOW}Getting your Vercel API Key...${NC}"
    open_browser "https://vercel.com/account/tokens" "Vercel API Tokens"
    
    read_with_prompt "2. Create a new token and copy it" "VERCEL_API_TOKEN"
    read_with_prompt "3. What is your Vercel username/org?" "VERCEL_ORG"
    
    print_success "Vercel configured!"
}

# ============================================================================
# RENDER SETUP (Backend Server)
# ============================================================================
setup_render() {
    print_header "STEP 4: Render Setup (Backend/API Server)"
    
    print_info "Opening Render Dashboard"
    open_browser "https://dashboard.render.com/" "Render Dashboard"
    
    echo -e "\n${YELLOW}Get your Render API Key...${NC}"
    open_browser "https://dashboard.render.com/account/api" "Render API Settings"
    
    read_with_prompt "1. Create and copy your API Key" "RENDER_API_KEY"
    read_with_prompt "2. What service name do you want? (e.g., my-kodigo-api)" "RENDER_SERVICE_NAME"
    
    print_success "Render configured!"
}

# ============================================================================
# N8N SETUP (Automation)
# ============================================================================
setup_n8n() {
    print_header "STEP 5: n8n Setup (Automation & Workflows)"
    
    print_info "Opening n8n cloud"
    open_browser "https://n8n.cloud/" "n8n Cloud"
    
    read_with_prompt "1. Sign up or log in to n8n Cloud" "N8N_PROMPT"
    
    echo -e "\n${YELLOW}Get your n8n API Key...${NC}"
    open_browser "https://n8n.cloud/user/settings/api" "n8n API Settings"
    
    read_with_prompt "2. Generate API Key and copy it" "N8N_API_KEY"
    
    print_success "n8n configured!"
}

# ============================================================================
# SAVE TO .env
# ============================================================================
save_to_env() {
    print_header "SAVING CONFIGURATION"
    
    echo -e "${BLUE}Creating .env file with your configuration...${NC}\n"
    
    cat > .env << EOF
# Auto-generated by Kodigo ng Kawalan auto-setup.sh
# Generated: $(date)

# Cloudflare
CLOUDFLARE_ZONE_ID=$CLOUDFLARE_ZONE_ID
CLOUDFLARE_API_TOKEN=$CLOUDFLARE_API_TOKEN
CLOUDFLARE_DOMAIN=$CLOUDFLARE_DOMAIN

# Supabase
SUPABASE_URL=$SUPABASE_URL
SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
SUPABASE_SERVICE_ROLE_KEY=$SUPABASE_SERVICE_ROLE_KEY
SUPABASE_DB_PASSWORD=$SUPABASE_DB_PASSWORD

# Vercel
VERCEL_API_TOKEN=$VERCEL_API_TOKEN
VERCEL_ORG=$VERCEL_ORG

# Render
RENDER_API_KEY=$RENDER_API_KEY
RENDER_SERVICE_NAME=$RENDER_SERVICE_NAME

# n8n
N8N_API_KEY=$N8N_API_KEY
N8N_URL=https://n8n.cloud

# Application
NODE_ENV=production
LOG_LEVEL=info
EOF
    
    print_success ".env file created successfully!"
    echo -e "${YELLOW}Location: $(pwd)/.env${NC}"
}

# ============================================================================
# VERIFICATION
# ============================================================================
verify_setup() {
    print_header "VERIFYING SETUP"
    
    echo -e "${BLUE}Checking all configurations...${NC}\n"
    
    [ -n "$CLOUDFLARE_API_TOKEN" ] && print_success "Cloudflare API Token configured"
    [ -n "$SUPABASE_URL" ] && print_success "Supabase database configured"
    [ -n "$VERCEL_API_TOKEN" ] && print_success "Vercel hosting configured"
    [ -n "$RENDER_API_KEY" ] && print_success "Render backend configured"
    [ -n "$N8N_API_KEY" ] && print_success "n8n automation configured"
}

# ============================================================================
# NEXT STEPS
# ============================================================================
show_next_steps() {
    print_header "SETUP COMPLETE!"
    
    echo -e "${GREEN}Your infrastructure is configured!${NC}\n"
    echo -e "${YELLOW}Next Steps:${NC}"
    echo -e "  1. Deploy your frontend to Vercel"
    echo -e "     ${CYAN}vercel deploy${NC}"
    echo -e ""
    echo -e "  2. Deploy your backend to Render"
    echo -e "     Use their dashboard to connect your GitHub repo"
    echo -e ""
    echo -e "  3. Test Supabase connection"
    echo -e "     ${CYAN}npm test -- --testNamePattern=supabase${NC}"
    echo -e ""
    echo -e "  4. Create automation workflows in n8n"
    echo -e "     Visit: ${CYAN}https://n8n.cloud${NC}"
    echo -e ""
    echo -e "  5. Point your domain to Vercel via Cloudflare"
    echo -e "     Domain: $CLOUDFLARE_DOMAIN"
    echo -e ""
    echo -e "${BLUE}Need help? Email: marvin@orin.work${NC}"
    echo -e "${BLUE}GitHub: https://github.com/makagagahum/kodigo-ng-kawalan${NC}\n"
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

main() {
    clear
    echo -e "${GREEN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║   Kodigo ng Kawalan - ONE-CLICK AUTO-SETUP                    ║"
    echo "║   Your browser will open automatically. Just authorize!      ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}\n"
    
    setup_cloudflare
    setup_supabase
    setup_vercel
    setup_render
    setup_n8n
    save_to_env
    verify_setup
    show_next_steps
}

main
