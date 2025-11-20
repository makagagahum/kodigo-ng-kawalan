#!/bin/bash

# QUICK_DEPLOY.sh - Deploy ORIN Revamp to Render in 3 minutes
# This script automates the deployment to Render's free tier

set -e

echo "🚀 ORIN Revamp - Quick Deploy to Render"
echo "======================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Verify prerequisites
echo -e "${BLUE}Step 1: Checking prerequisites...${NC}"

if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}❌ Node.js not found. Please install Node.js 20+${NC}"
    echo "   Download: https://nodejs.org"
    exit 1
fi

echo -e "${GREEN}✓ Node.js $(node -v) found${NC}"

if ! command -v npm &> /dev/null; then
    echo -e "${YELLOW}❌ npm not found${NC}"
    exit 1
fi

echo -e "${GREEN}✓ npm $(npm -v) found${NC}"

if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}❌ Git not found. Please install Git${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Git found${NC}"

echo ""
echo -e "${BLUE}Step 2: Installing dependencies...${NC}"

# Step 2: Install root dependencies
if [ ! -d "node_modules" ]; then
    npm install
    echo -e "${GREEN}✓ Root dependencies installed${NC}"
else
    echo -e "${GREEN}✓ Root dependencies already installed${NC}"
fi

# Step 3: Install orin-revamp dependencies
echo ""
echo -e "${BLUE}Step 3: Installing orin-revamp dependencies...${NC}"

cd orin-revamp

if [ ! -d "node_modules" ]; then
    npm install
    echo -e "${GREEN}✓ orin-revamp dependencies installed${NC}"
else
    echo -e "${GREEN}✓ orin-revamp dependencies already installed${NC}"
fi

cd ..

# Step 4: Build orin-revamp
echo ""
echo -e "${BLUE}Step 4: Building orin-revamp (Vite)...${NC}"

npm run build
echo -e "${GREEN}✓ orin-revamp built successfully${NC}"

# Step 5: Verify build
echo ""
echo -e "${BLUE}Step 5: Verifying build...${NC}"

if [ ! -d "orin-revamp/dist" ]; then
    echo -e "${YELLOW}❌ Build failed: orin-revamp/dist not found${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Build verified: $(ls -1 orin-revamp/dist | wc -l) files${NC}"

# Step 6: Test local server
echo ""
echo -e "${BLUE}Step 6: Testing local server...${NC}"

echo -e "${YELLOW}Starting server on http://localhost:3000${NC}"
echo -e "${YELLOW}Press Ctrl+C to stop${NC}"

# Run server with timeout (30 seconds) for health check
timeout 30s npm start &
SERVER_PID=$!

# Wait for server to start
sleep 3

# Health check
if curl -s http://localhost:3000 > /dev/null; then
    echo -e "${GREEN}✓ Server is running on http://localhost:3000${NC}"
    kill $SERVER_PID 2>/dev/null || true
else
    echo -e "${YELLOW}⚠ Server health check failed${NC}"
    kill $SERVER_PID 2>/dev/null || true
fi

# Step 7: Git status
echo ""
echo -e "${BLUE}Step 7: Git status${NC}"

if git status --porcelain | grep -q .; then
    echo -e "${YELLOW}⚠ Uncommitted changes detected:${NC}"
    git status --short
    echo ""
    echo -e "${YELLOW}Push to deploy? (y/n)${NC}"
    read -r response
    if [ "$response" = "y" ]; then
        git add .
        git commit -m "feat: Prepare for Render deployment"
        git push origin main
        echo -e "${GREEN}✓ Changes pushed to GitHub${NC}"
    fi
else
    echo -e "${GREEN}✓ Working directory clean${NC}"
    echo -e "${GREEN}✓ Ready to deploy to Render${NC}"
fi

# Step 8: Deployment instructions
echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}✅ LOCAL BUILD COMPLETE!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo -e "${BLUE}🚀 Next Steps to Deploy to Render:${NC}"
echo ""
echo "1. Visit: ${YELLOW}https://dashboard.render.com${NC}"
echo "2. Click: ${YELLOW}New + Web Service${NC}"
echo "3. Select: ${YELLOW}GitHub${NC}"
echo "4. Repository: ${YELLOW}kodigo-ng-kawalan${NC}"
echo "5. Name: ${YELLOW}orin-revamp${NC}"
echo "6. Runtime: ${YELLOW}Docker${NC}"
echo "7. Instance: ${YELLOW}Free (0.5 CPU, 512MB RAM)${NC}"
echo "8. Click: ${YELLOW}Create Web Service${NC}"
echo ""
echo "✨ Render will auto-deploy on git push!"
echo ""
echo -e "${BLUE}📖 Documentation:${NC}"
echo "   Deployment Guide: ${YELLOW}DEPLOY_ORIN_REVAMP.md${NC}"
echo "   Tech Stack: ${YELLOW}TECH_STACK.md${NC}"
echo ""
echo -e "${GREEN}Happy deploying! 🎉${NC}"
