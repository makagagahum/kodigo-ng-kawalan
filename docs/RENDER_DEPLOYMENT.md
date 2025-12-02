# Render Deployment Guide for Kodigo ng Kawalan

This document provides comprehensive instructions for deploying the **kodigo-ng-kawalan** full-stack application on Render.com.

## Overview

The application consists of:
- **Frontend**: React 19 + Vite (orin-revamp)
- **Backend**: Node.js Express server (v20+)
- **Database**: PostgreSQL (via Supabase)
- **Infrastructure**: Docker-based deployment on Render

## Architecture

```
Render.com (Web Service)
  |
  +-- Node.js v20
  +-- Express Server (server.js)
      |
      +-- Serves orin-revamp/dist (React build)
      +-- Handles SPA routing (fallback to index.html)
      +-- Health check endpoint: /health
      +-- Status endpoint: /api/status
      +-- Environment variables (Supabase, JWT, API keys)
```

## Prerequisites

1. **GitHub Account**: Repository must be pushed to GitHub
2. **Render Account**: Free tier account at render.com
3. **Environment Variables**: All values from .env.example configured

## Environment Variables

Set these variables in Render dashboard under Environment:

```
# Node Environment
NODE_ENV=production
PORT=3000

# Supabase Configuration
VITE_SUPABASE_URL=<your_supabase_url>
VITE_SUPABASE_ANON_KEY=<your_anon_key>
SUPABASE_URL=<your_supabase_url>
SUPABASE_SERVICE_ROLE_KEY=<your_service_role_key>

# JWT Configuration
JWT_SECRET=<secure_random_string>
JWT_ROUNDS=10

# API Configuration
API_BASE_URL=<your_render_url>
API_NODE_ENV=production

# N8N Configuration (if needed)
N8N_HOST=<your_n8n_instance>
N8N_WEBHOOK_URL=<your_webhook_url>

# Cloudflare Configuration (if needed)
CLOUDFLARE_API_TOKEN=<your_token>
CLOUDFLARE_ZONE_ID=<your_zone_id>

# Logging
LOG_LEVEL=info
```

## Deployment Steps

### Step 1: Connect GitHub Repository

1. Go to [render.com](https://render.com)
2. Click "New +" → "Web Service"
3. Select "Build and deploy from a Git repository"
4. Connect your GitHub account and select `makagagahum/kodigo-ng-kawalan`
5. Choose branch: `main`

### Step 2: Configure Service

**Name**: kodigo-ng-kawalan (or your preferred name)

**Environment**: 
- Select "Docker" (Render will auto-detect Dockerfile)
- Region: Choose closest to your users

**Plan**: 
- Select "Free" for free tier
- Specifications: 0.5 GB RAM, Shared CPU

### Step 3: Set Environment Variables

1. In Render dashboard, go to Environment
2. Add all variables from the "Environment Variables" section above
3. Make sure values are accurate and properly formatted

### Step 4: Deploy

1. Click "Create Web Service"
2. Render will automatically:
   - Clone your repository
   - Build the Docker image
   - Install dependencies
   - Build the orin-revamp React app
   - Start the Express server
3. Monitor logs in the Render dashboard

## Files Structure for Render

```
project-root/
├── Dockerfile              # Multi-stage Docker build
├── .dockerignore           # Exclude unnecessary files from Docker build
├── render.yaml             # Render infrastructure as code
├── package.json            # npm dependencies and scripts
├── server.js               # Express server entry point
├── orin-revamp/            # React Vite app
│   ├── package.json
│   ├── vite.config.ts
│   └── src/                # React source files
├── .env.example            # Environment variables template
└── README.md               # Project documentation
```

## Build and Start Commands

**Build Command** (from render.yaml):
```bash
npm run build
```
This runs:
1. `cd orin-revamp && npm run build` - Builds React app
2. Creates dist/ folder with static assets

**Start Command** (from render.yaml):
```bash
npm run start
```
This runs:
1. `node server.js` - Starts Express server on PORT 3000
2. Server serves React build from `orin-revamp/dist`
3. Handles SPA routing with fallback to index.html

## Health Checks

Render automatically monitors your application health:

**Health Check Endpoint**: `GET /health`

Response:
```json
{
  "status": "ok",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

**API Status Endpoint**: `GET /api/status`

Response:
```json
{
  "status": "running",
  "environment": "production",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

## Troubleshooting

### Build Fails

**Check**:
1. Verify all environment variables are set correctly
2. Check build logs in Render dashboard
3. Ensure `package.json` scripts are correct
4. Verify `orin-revamp/package.json` exists and has build script

### App Won't Start

**Check**:
1. Review startup logs in Render dashboard
2. Verify PORT environment variable is set to 3000
3. Ensure server.js can access `orin-revamp/dist`
4. Check Node.js version (requires v20+)

### Out of Memory

**Free tier has 0.5 GB RAM limit**:
- Reduce build artifacts
- Check .dockerignore is properly configured
- Consider upgrading to paid tier

### API Connection Issues

**Check**:
1. Verify SUPABASE_URL and keys in environment
2. Confirm Supabase project is active
3. Check CORS configuration if needed
4. Review application logs for specific errors

## Auto-Deployment

Auto-deployment is enabled in `render.yaml`:
- Every push to `main` branch triggers automatic rebuild
- Deployment takes 5-10 minutes
- Previous version stays active until new build succeeds
- Rollback available via Render dashboard

## Manual Redeployment

To manually trigger a new deployment:

1. Go to your service in Render dashboard
2. Click "Manual Deploy" → "Latest Commit"
3. Or push a new commit to main branch

## Monitoring

In Render Dashboard:

1. **Logs**: View real-time application logs
2. **Metrics**: CPU, memory, and request metrics
3. **Events**: Deployment history and status
4. **Alerts**: Set up notifications for failures

## Performance Optimization

### Frontend
- React build is minified and optimized by Vite
- Static files served with proper cache headers
- SPA routing optimized for fast navigation

### Backend
- Express server runs in production mode
- Static files served from disk cache
- Keep-alive connections for efficiency

### Docker
- Multi-stage build reduces final image size
- .dockerignore excludes unnecessary files
- Node modules cached between builds

## Database Connection

Supabase connection through environment variables:

1. Supabase PostgreSQL is accessed via `SUPABASE_URL`
2. Authentication via `SUPABASE_SERVICE_ROLE_KEY`
3. Client-side uses `VITE_SUPABASE_ANON_KEY`
4. Connection pooling handled by Supabase

## Security Considerations

1. **Environment Variables**: Never commit .env file
2. **HTTPS**: Render automatically provides HTTPS
3. **Node Version**: Uses v20 LTS for security patches
4. **Dependencies**: Keep package.json dependencies updated
5. **Secrets**: Store sensitive data only in Render environment variables

## Rollback Procedure

If deployment causes issues:

1. Go to Render dashboard
2. Find your service
3. Click "Deployments" tab
4. Select the previous successful deployment
5. Click "Redeploy"
6. Service reverts to previous version

## Support and Additional Resources

- **Render Docs**: https://render.com/docs
- **Supabase Docs**: https://supabase.com/docs
- **Express.js Docs**: https://expressjs.com
- **React Vite Docs**: https://vitejs.dev
- **Docker Docs**: https://docs.docker.com

## FAQ

**Q: How much does it cost?**
A: The free tier is perfect for development. Paid plans start at $7/month.

**Q: Can I use a custom domain?**
A: Yes, add your domain in Render's settings (CNAME pointing to Render).

**Q: How do I update the application?**
A: Just push to the main branch on GitHub, Render auto-deploys.

**Q: Can I have multiple environments (staging, production)?**
A: Yes, create separate services pointing to different branches.

**Q: How do I view logs?**
A: Go to your service → Logs tab in Render dashboard.

---

**Last Updated**: 2024
**Status**: Ready for Render Deployment
