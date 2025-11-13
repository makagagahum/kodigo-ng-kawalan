# ORIN AI - Production Tech Stack

## Overview
Enterprise-grade full-stack deployment on free-tier services ($0/month)

## Backend
- **Node.js 20+** - Runtime
- **Express.js 4** - API framework
- **TypeScript** - Type safety
- **Supabase PostgreSQL** - Database (zero-cost)
- **JWT + Passport** - Authentication

## Frontend
- **Next.js 14** - React framework with SSR
- **React 18** - UI library
- **Supabase Client** - Database client

## Infrastructure
- **Render.com** - App hosting (free tier)
- **Supabase** - Database & Auth (free tier)
- **Cloudflare** - DNS, CDN, WAF (free tier)
- **Docker** - Containerization

## Development
- **ESLint** - Code quality
- **Prettier** - Code formatting
- **Jest** - Testing framework
- **npm** - Package management

## Configuration
- See `.env.example` for required environment variables
- Dockerfile included for Render deployment
- package.json has all dependencies and scripts

## Deployment
```bash
# Build
npm run build

# Production
npm start

# Docker
docker build -t orin .
docker run -p 3000:3000 orin
```

## Cost
**$0/month forever** - All services on free tier
