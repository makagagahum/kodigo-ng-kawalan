# ORIN AI - Production Tech Stack

## The Why Before The What

I chose these tools because:

1. **Everything stacks in layers** - Frontend, backend, database, infrastructure, each a distinct layer
2. **Free tier forever** - Not as a limitation, but as a feature. If you can't run it free, you don't understand it well enough
3. **Type safety matters** - TypeScript forces you to think about data flow. Mistakes become compiler errors, not 2 AM pagers
4. **Each tool has ONE job** - Express handles HTTP, Supabase handles data + auth, Render handles deployment. No bloat.

This isn't a "free tier startup" stack. It's *enterprise-grade tooling on free tier pricing*. There's a massive difference.

## Frontend Layer

- **Next.js 14** - React framework with server-side rendering. Why? Because rendering on the server means less JavaScript sent to browsers, and that means faster. Simpler. More resilient.
- **React 18** - UI library that understands components as layers themselves. Each component is its own predictable system.
- **Supabase Client** - Direct database access from the browser (with row-level security). No complex middleware. Direct path.

## Backend Layer

- **Node.js 20+** - Async runtime. Non-blocking I/O means you can handle 10,000 concurrent connections on a single dyno. That's scale.
- **Express.js 4** - Minimal framework. You build the layers you need, nothing you don't.
- **TypeScript** - Forces type discipline. The compiler becomes your first line of defense against bugs.

## Data Layer

- **Supabase PostgreSQL** - PostgreSQL is 25 years of reliability. Supabase adds real-time, authentication, and row-level security. All free tier.
- **JWT + Passport** - Stateless authentication. No session layer overhead. Scales horizontally because sessions live in tokens, not servers.

PostgreSQL isn't free because Supabase is cheap. It's free because PostgreSQL is *that good* and Supabase built a business model around it.

## Infrastructure Layer

- **Render.com** - Container hosting that replaces Heroku. Push code, it runs. Free tier includes PostgreSQL backups and auto-deploys. Read that again: *auto-deploys from git*.
- **Cloudflare** - DNS, WAF, DDoS protection, free tier. They built this for scale and make money on upgrades, not by gatekeeping basics.
- **Docker** - Containerization means your dev environment matches production exactly. No "works on my machine" disasters. One layer that's identical everywhere.

## Development Layer

- **ESLint** - Code quality automation. Catches consistency issues before humans waste time on code review
- **Prettier** - Code formatting opinion, no arguments. When code format is automatic, developers focus on logic
- **Jest** - Testing framework that's fast and simple. You write tests *because* it doesn't get in your way
- **npm** - Package management. Standard. No surprises.

## The Stack Visually

```
Browser (React 18)
    ↓
Next.js 14 (SSR)
    ↓
Express + TypeScript (Node.js)
    ↓
Supabase Client → JWT Auth
    ↓
PostgreSQL (Supabase)
    ↓
Render (Container + Auto-deploy)
    ↓
Cloudflare (DNS + DDoS + WAF)
```

Each layer has one job. Each layer is replaceable. You understand exactly where every piece fits.

## Configuration

- See `.env.example` for required environment variables
- Dockerfile included for Render deployment (same image everywhere)
- package.json has all dependencies and scripts

## Deployment Commands

```bash
# Build
npm run build

# Production (local testing)
npm start

# Docker (what runs on Render)
docker build -t orin .
docker run -p 3000:3000 orin
```

## The Real Cost

**$0/month forever**

Not $0 while you're small. Not $0 until it breaks. $0.

Every service: Render free tier, Supabase free tier, Cloudflare free tier, GitHub (free tier), Docker (free).

When you're ready to scale, you upgrade individual layers without rewriting everything. That's the design win. That's layering working.

## Why Each Tier Matters

Free tier isn't about cheapness. It's about **understanding costs**. When you run on free tier, you learn exactly what resources you use because you hit the limits:

- Supabase free tier: 50 MB storage (teaches you about data efficiency)
- Render free tier: 1 instance, shared CPU (teaches you about optimization)
- Cloudflare free tier: 3 page rules (teaches you about CDN strategy)

Hit a limit? Upgrade that layer. Leave the rest alone. That's how architecture works.
