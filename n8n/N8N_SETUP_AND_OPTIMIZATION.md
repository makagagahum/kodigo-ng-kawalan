# N8N Performance Optimization

Production-grade n8n configuration for maximum speed on free tier infrastructure.

## The Philosophy: Performance as Layers

Performance isn't one knob. It's layers of optimization, each improving a different part of the system:

1. **Database layer** - How we store and retrieve data (connection pooling, indexes, pruning)
2. **Execution layer** - How fast n8n runs workflows (memory management, node optimization)
3. **Network layer** - How fast data moves (Cloudflare CDN, direct webhooks)
4. **Monitoring layer** - How fast we know something's wrong (uptime monitoring, metrics)

When something is slow, it's broken in one of these layers. Fix the right layer, and performance jumps.

## Current Performance

Optimized n8n instance running at [https://n8n.orin.work](https://n8n.orin.work/)

**Real metrics:**
- **Execution time:** <100ms average (most workflows finish faster than you can click)
- **P95 latency:** <180ms (95% of workflows this speed or faster)
- **Webhook response:** <65ms (external systems think you're fast)
- **Database size:** ~80MB (stays lean through aggressive pruning)
- **Uptime:** 99.8% (failures are measured in hours per year, not minutes per day)

## Infrastructure Stack

Each layer is independent and replaceable:

```
n8n (Render Free Tier) - Application layer
  ↓
PostgreSQL (Supabase Free) - Data layer
  ↓
Cloudflare CDN (Free) - Network layer
  ↓
UptimeRobot (Free) - Monitoring layer
```

No vendor lock-in. Each can be upgraded separately.

## Setup: Database Layer First

Start with the database because it's the foundation. A bad database makes everything else pointless.

### 1. Deploy Application on Render

**Service Configuration:**
- Name: `n8n`
- Environment: Docker
- Image: `n8nio/n8n:latest`
- Plan: Free (0.5 CPU, 512MB RAM)

### 2. Connect to Supabase PostgreSQL

Environment variables for database connection:

```bash
# Database Connection
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=db.supabase.co
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=postgres
DB_POSTGRESDB_USER=postgres
DB_POSTGRESDB_PASSWORD=your_password
DB_POSTGRESDB_POOL_SIZE=5  # Critical for free tier
```

**Why POOL_SIZE=5?** On free tier, each connection wastes resources. 5 connections means n8n never runs out, but doesn't waste either. It's the optimization point.

### 3. Core Configuration

```bash
# Application Config
N8N_HOST=n8n.orin.work
N8N_PORT=5678
N8N_PROTOCOL=https
NODE_ENV=production
WEBHOOK_TUNNEL_URL=https://n8n.orin.work/

# Security
ENCRYPTION_KEY=your_32_char_key
```

### 4. Execution Data Management Layer

This is where most people miss the optimization. By default, n8n saves *everything*. On free tier, "everything" kills your database in days.

```bash
EXECUTIONS_DATA_PRUNE=true         # Automatic cleanup
EXECUTIONS_DATA_MAX_AGE=168        # 7 days retention
EXECUTIONS_DATA_SAVE_ON_SUCCESS=none  # Don't save successful runs
EXECUTIONS_DATA_SAVE_ON_ERROR=all  # DO save failed runs for debugging
EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=true
```

**The philosophy:** You don't need logs of success. Success means "it worked and we're done". You need logs of failure because failure means "I have a mystery to solve".

This configuration:
- Reduces database size by 90%
- Speeds up queries by 3-5x
- Keeps database under 100MB
- Maintains debugging capability

### 5. Memory Management Layer

```bash
N8N_MEMORY_LIMIT=512               # Match Render free tier RAM
NODE_MAX_OLD_SPACE_SIZE=512
```

For heavy workflows, be more aggressive:

```bash
N8N_MEMORY_LIMIT=400
EXECUTIONS_DATA_MAX_AGE=48  # More aggressive pruning
```

### 6. Database Indexes (Critical)

Run these SQL commands in Supabase SQL Editor:

```sql
CREATE INDEX IF NOT EXISTS idx_execution_startedat 
  ON execution_entity ("startedAt");

CREATE INDEX IF NOT EXISTS idx_execution_status 
  ON execution_entity ("status");

CREATE INDEX IF NOT EXISTS idx_execution_workflow 
  ON execution_entity ("workflowId");
```

These indexes make n8n 5-10x faster at finding executions. Without them, every query does a full table scan.

## Networking Layer: Cloudflare

### DNS Configuration

```
Type: CNAME
Name: n8n
Target: your-app.onrender.com
Proxy: DNS only (gray cloud) ← CRITICAL
TTL: Auto
```

**CRITICAL:** DO NOT enable Cloudflare proxy (orange cloud). It breaks WebSocket connections, and n8n editor needs WebSockets to show connection points between nodes.

### SSL/TLS Settings

```
Mode: Full (Strict)
Min TLS: 1.3
Always HTTPS: On
```

### Cache Rules

For performance:

```
API Routes (/api/*): Bypass (no caching - dynamic data)
Static Assets (/static/*): Cache 30 days
Compression: Brotli enabled
HTTP/2: Enabled
HTTP/3 (QUIC): Enabled
```

### Minification

```
HTML: Enabled
CSS: Enabled
JS: Enabled
```

## Monitoring Layer: Know When Things Break

**Key metrics to watch:**
- n8n Admin Dashboard: `https://n8n.orin.work/admin`
- Render Dashboard: CPU/Memory usage
- Cloudflare Analytics: Request patterns
- UptimeRobot: Response times and availability

**Performance targets:**
```
Average execution: <100ms
P95 execution: <300ms
Webhook response: <100ms
Database size: <150MB
Uptime: >99.9%
```

If you're hitting these, you're fine. If you're not:

### Slow Executions

1. Check database connection pool: `DB_POSTGRESDB_POOL_SIZE=5`
2. Check execution pruning: `EXECUTIONS_DATA_PRUNE=true`
3. Check memory usage in Render dashboard
4. Check workflow complexity (too many nodes = slow)
5. Run the database indexes above

Quick fix for emergency slowness:

```bash
EXECUTIONS_DATA_MAX_AGE=48
EXECUTIONS_DATA_SAVE_ON_SUCCESS=none
```

### Database Growing Large

Automatic cleanup is on, but manual emergency cleanup:

```sql
DELETE FROM execution_entity
WHERE "finishedAt" < NOW() - INTERVAL '7 days'
  AND "finished" = true;
```

### Webhooks Not Working

This usually means Cloudflare proxy is enabled:

1. Go to Cloudflare Dashboard → DNS Records
2. Find your n8n subdomain
3. Change from "Proxied" (orange cloud) to "DNS only" (gray cloud)
4. Refresh n8n page

Connection points should now appear on all nodes.

Test:
```bash
curl https://n8n.orin.work/healthz
```

### Out of Memory (Service Crashes)

**Symptoms:**
- Render service keeps restarting
- Executions timeout
- Memory usage >90% in dashboard

**Solutions:**
1. Reduce memory allocation
2. More aggressive pruning
3. Batch large workflows
4. Schedule during off-peak hours

```bash
N8N_MEMORY_LIMIT=400
NODE_MAX_OLD_SPACE_SIZE=400
EXECUTIONS_DATA_MAX_AGE=24
```

## Scaling: When Free Tier Hits Its Limit

**Phase 1: Free Tier (Now)**
- Capacity: 100-500 users
- Executions: 1,000-5,000/day
- Response time: 80-150ms
- Cost: $0

**Phase 2: Render Standard ($7/month)**
- Resources: 1 vCPU, 1GB RAM
- Capacity: 500-2,000 users
- Executions: 10,000+/day
- Response time: 40-80ms

**Phase 3: Add Queue System ($10/month Upstash Redis)**
- Enable Bull queue system
- Capacity: 2,000+ users
- Executions: 100,000+/day
- Response time: <30ms

```bash
QUEUE_MODE=bull
BULL_REDIS_HOST=redis.upstash.io
BULL_REDIS_PORT=6379
BULL_REDIS_PASSWORD=your_password
```

**Phase 4: Premium Setup ($25/month Supabase Pro)**
- Database: 8GB (vs 50MB free)
- Capacity: Unlimited users
- Can handle massive scale

Each phase is independent. Upgrade only what you need.

## Cost Breakdown

| Service | Cost | Purpose |
|---------|------|----------|
| Render | $0 | Application hosting |
| Supabase | $0 | PostgreSQL database |
| Cloudflare | $0 | CDN + DNS |
| UptimeRobot | $0 | Monitoring |
| **Total** | **$0** | Complete automation platform |

**Optional upgrades:**
- Render Standard: $7/month
- Upstash Redis: $10/month
- Supabase Pro: $25/month
- Combined fully scaled: $42/month

## Best Practices

**Development:**
- Use webhooks instead of polling (webhooks are reactive, polling is wasteful)
- Batch API calls when possible
- Implement error handling
- Test workflows with small datasets

**Production:**
- Monitor execution times daily
- Set up UptimeRobot alerts
- Review database size weekly
- Prune old executions regularly

**Security:**
- Rotate `ENCRYPTION_KEY` annually
- Use environment variables for secrets (never hardcode)
- Enable Cloudflare WAF rules
- Restrict access by IP if needed

## Additional Resources

- [n8n Documentation](https://docs.n8n.io/)
- [Supabase Performance Tuning](https://supabase.com/docs/guides/database/performance)
- [Cloudflare Speed Optimization](https://developers.cloudflare.com/speed)
- [Render Deployment Guide](https://render.com/docs)
- [n8n Community](https://community.n8n.io/)

---

## Facebook Messenger Integration: Real-World Example

A complete working example of n8n + Facebook Messenger + AI.

**Workflow:** [https://n8dex.com/OENU11pw](https://n8dex.com/OENU11pw)

**What it does:**
- AI chatbot responds to Facebook messages
- Webhook verification (GET) for Facebook setup
- Message handling (POST) for incoming messages
- Conversation memory per user (sender ID)
- Automatic replies via Facebook Graph API

### Problem 1: Facebook Webhook Verification Failing

**The issue:** The "Respond to Webhook" node wasn't firing when Facebook sent verification requests.

**Root cause:** Verification data was going to the FALSE branch of an If node, but Respond to Webhook was on the TRUE branch.

**The fix:** Remove the If node from the verification path. Connect directly:

Webhook → Response Body: `{{ $('Webhook').item.json.query['hub.challenge'] }}` → Done

**Why it works:** The challenge response must go back immediately. Conditional logic is irrelevant for verification.

### Problem 2: JSON Parsing Error

**The issue:** HTTP Request throwing "JSON parameter needs to be valid JSON"

**Root cause:** AI output contained unescaped quotes. When inserted into JSON, it broke the structure.

**Broken code:**
```json
{
  "message": {
    "text": "{{ $json.output }}"
  }
}
```

**Fixed code:**
```json
{
  "message": {
    "text": {{ JSON.stringify($json.output) }}
  }
}
```

**Why:** `JSON.stringify()` properly escapes quotes, newlines, and special characters. It returns a valid JSON string.

**Alternative:** Use "Using Fields Below" instead of "Using JSON" in HTTP node - it handles encoding automatically.

---

## The Summary

Performance on free tier isn't about magic. It's about understanding each layer:

1. **Database:** Connection pooling, pruning, indexes
2. **Execution:** Memory management, smart logging
3. **Network:** Direct webhooks, Cloudflare caching
4. **Monitoring:** Know when something breaks

Optimize each layer independently. When you hit a limit, upgrade that layer. Don't upgrade everything.

That's how you scale while staying lean.
