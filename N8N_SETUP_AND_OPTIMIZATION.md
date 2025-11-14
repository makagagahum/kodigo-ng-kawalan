# N8N Performance Optimization

Production-grade n8n configuration for maximum speed on free tier infrastructure.

## Performance Overview

Optimized n8n instance at [https://n8n.orin.work](https://n8n.orin.work)

**Current metrics:**
- Execution time: <100ms average
- P95 latency: <180ms
- Webhook response: <65ms
- Database size: ~80MB
- Uptime: 99.8%

## Infrastructure Stack

```
n8n (Render Free Tier)
  ↓
PostgreSQL (Supabase Free)
  ↓
Cloudflare CDN (Free)
  ↓
UptimeRobot (Free)
```

## Quick Start

### 1. Deploy on Render

**Service Configuration:**
- Name: `n8n`
- Environment: Docker
- Image: `n8nio/n8n:latest`
- Plan: Free (0.5 CPU, 512MB RAM)

### 2. Environment Variables

```bash
# Database
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=db.supabase.co
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=postgres
DB_POSTGRESDB_USER=postgres
DB_POSTGRESDB_PASSWORD=your_password
DB_POSTGRESDB_POOL_SIZE=5

# Core Config
N8N_HOST=n8n.orin.work
N8N_PORT=5678
N8N_PROTOCOL=https
NODE_ENV=production
WEBHOOK_TUNNEL_URL=https://n8n.orin.work/

# Security
ENCRYPTION_KEY=your_32_char_key

# Performance Tuning
EXECUTIONS_DATA_PRUNE=true
EXECUTIONS_DATA_MAX_AGE=168
EXECUTIONS_DATA_SAVE_ON_SUCCESS=none
EXECUTIONS_DATA_SAVE_ON_ERROR=all
EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=true

# Memory Management
N8N_MEMORY_LIMIT=512
NODE_MAX_OLD_SPACE_SIZE=512

# Queue (Optional - for scaling)
QUEUE_MODE=off  # Set to 'bull' with Redis for heavy loads
```

### 3. Cloudflare DNS

```
Type: CNAME
Name: n8n
Target: your-app.onrender.com
Proxy: DNS only (gray cloud) ⚠️ CRITICAL: DO NOT enable Cloudflare proxy (orange cloud) - it breaks WebSocket connections needed for n8n editor
TTL: Auto
```

**SSL/TLS:**
- Mode: Full (Strict)
- Min TLS: 1.3
- Always HTTPS: On

## Performance Optimizations

### Database Tuning

**Connection Pooling**
```bash
DB_POSTGRESDB_POOL_SIZE=5  # Optimal for free tier
```

**Execution Data Management**
```bash
EXECUTIONS_DATA_PRUNE=true
EXECUTIONS_DATA_MAX_AGE=168  # 7 days retention
EXECUTIONS_DATA_SAVE_ON_SUCCESS=none  # Don't save successful runs
EXECUTIONS_DATA_SAVE_ON_ERROR=all  # Keep failed runs for debugging
```

This configuration:
- Reduces DB size by 90%
- Speeds up queries by 3-5x
- Keeps database under 100MB
- Maintains debugging capability

**Postgres Indexes** (Run on Supabase SQL Editor)
```sql
CREATE INDEX IF NOT EXISTS idx_execution_startedat 
  ON execution_entity ("startedAt");
CREATE INDEX IF NOT EXISTS idx_execution_status 
  ON execution_entity ("status");
CREATE INDEX IF NOT EXISTS idx_execution_workflow 
  ON execution_entity ("workflowId");
```

### Workflow Optimization

**Efficient Webhook Usage**
```bash
WEBHOOK_TUNNEL_URL=https://n8n.orin.work/
```
- Direct domain (no tunneling)
- ~50ms faster response
- No ngrok/localtunnel overhead

**Execution Limits**
```bash
N8N_EXECUTION_HISTORY_MAX_ITEMS=100
```

### Cloudflare Caching

**Cache Rules:**
```
API Routes: /api/*
  Cache: Bypass (no caching for dynamic data)

Static Assets: /static/*
  Edge TTL: 30 days
  Browser TTL: 1 year
  Compression: Brotli
```

**Speed Settings:**
- Minification: HTML, CSS, JS enabled
- HTTP/2: Enabled
- HTTP/3 (QUIC): Enabled
- Early Hints: Enabled

### Memory Management

```bash
N8N_MEMORY_LIMIT=512  # Match Render free tier
NODE_MAX_OLD_SPACE_SIZE=512
```

For heavy workflows, reduce to:
```bash
N8N_MEMORY_LIMIT=400
EXECUTIONS_DATA_MAX_AGE=48  # More aggressive pruning
```

## Scaling Strategy

### Phase 1: Free Tier (Current)
- **Capacity:** 100-500 users
- **Executions:** 1,000-5,000/day
- **Response time:** 80-150ms
- **Cost:** $0

### Phase 2: Render Standard
- **Upgrade:** $7/month
- **Resources:** 1 vCPU, 1GB RAM
- **Capacity:** 500-2,000 users
- **Executions:** 10,000+/day
- **Response time:** 40-80ms

### Phase 3: Redis + Premium
- **Add:** Upstash Redis ($10/month)
- **Upgrade:** Render Pro ($25/month)
- **Capacity:** 2,000+ users
- **Executions:** 100,000+/day
- **Response time:** <30ms

**Redis Configuration:**
```bash
QUEUE_MODE=bull
BULL_REDIS_HOST=redis.upstash.io
BULL_REDIS_PORT=6379
BULL_REDIS_PASSWORD=your_password
```

## Monitoring

**Key Metrics:**
- n8n Dashboard: `https://n8n.orin.work/admin`
- Render: CPU/Memory usage
- Cloudflare: Request analytics
- UptimeRobot: Response times

**Performance Targets:**
```
Average execution: <100ms
P95 execution: <300ms
Webhook response: <100ms
Database size: <150MB
Uptime: >99.9%
```

## Troubleshooting

### Slow Executions

**Check:**
1. Database connection pool: `DB_POSTGRESDB_POOL_SIZE=5`
2. Execution data pruning: `EXECUTIONS_DATA_PRUNE=true`
3. Memory usage in Render dashboard
4. Workflow complexity (reduce unnecessary nodes)
5. Database indexes (see SQL commands above)

**Fix:**
```bash
# Reduce retention
EXECUTIONS_DATA_MAX_AGE=48

# Disable success logging
EXECUTIONS_DATA_SAVE_ON_SUCCESS=none
```

### Database Growing Large

**Manual cleanup:**
```sql
-- Delete old successful executions
DELETE FROM execution_entity 
WHERE "finishedAt" < NOW() - INTERVAL '7 days'
AND "finished" = true;
```

**Automate:**
```bash
EXECUTIONS_DATA_PRUNE=true
EXECUTIONS_DATA_MAX_AGE=168
```

### Webhooks Not Working

**Verify:**
1. `WEBHOOK_TUNNEL_URL` matches domain
2. Cloudflare DNS proxying enabled
3. SSL mode: Full (Strict)
4. Test: `curl https://n8n.orin.work/healthz`

### Out of Memory

**Symptoms:**
- Render service crashes
- Executions timeout
- High memory usage (>90%)

**Solutions:**
```bash
# Reduce memory allocation
N8N_MEMORY_LIMIT=400
NODE_MAX_OLD_SPACE_SIZE=400

# More aggressive pruning
EXECUTIONS_DATA_MAX_AGE=24

# Batch large workflows
# Schedule during off-peak hours
```

## Cost Breakdown

| Service | Cost | Purpose |
|---------|------|----------|
| Render | $0 | Application hosting |
| Supabase | $0 | PostgreSQL database |
| Cloudflare | $0 | CDN + DNS |
| UptimeRobot | $0 | Uptime monitoring |
| **Total** | **$0** | Complete automation platform |

**Optional paid upgrades:**
- Render Standard: $7/month (1GB RAM)
- Upstash Redis: $10/month (queue system)
- Supabase Pro: $25/month (8GB database)

## Best Practices

**Development:**
- Use webhooks instead of polling
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
- Use environment variables for secrets
- Enable Cloudflare WAF rules
- Restrict access by IP if needed

- ## Troubleshooting

**Missing Connection Points (+ Buttons) on Nodes:**

If your n8n nodes don't show connection points (the + buttons to wire nodes together), this is caused by Cloudflare proxy blocking WebSocket connections.

**Solution:**
- Go to Cloudflare Dashboard → DNS Records
- Find your n8n subdomain (e.g., n8n.yourdomain.com)
- Click Edit on the DNS record
- Change proxy status from "Proxied" (orange cloud) to "DNS only" (gray cloud)
- Save the changes
- Refresh your n8n page

The connection points should now appear on all nodes. This issue affects the n8n editor's real-time functionality which requires WebSocket support.

## Additional Resources

- [n8n Documentation](https://docs.n8n.io)
- [Supabase Performance Tips](https://supabase.com/docs/guides/database/performance)
- [Cloudflare Speed Optimization](https://developers.cloudflare.com/speed)
- [Render Deployment Guide](https://render.com/docs)

---

**Questions or issues?** Check [n8n community](https://community.n8n.io) or [GitHub issues](https://github.com/n8n-io/n8n/issues)


---

## Facebook Messenger Webhook Fixes (Nov 

**n8dex Workflow:** [https://n8dex.com/OENU11pw](https://n8dex.com/OENU11pw)

**Description:**
Facebook Messenger AI Chatbot with OpenAI integration. Handles webhook verification (GET) and incoming messages (POST). Includes working solutions for:
- Facebook webhook verification fix (hub.challenge response)
- JSON.stringify() fix for AI output to prevent JSON errors
- AI Agent with conversation memory using sender ID
- Automatic replies via Facebook Graph API

Based on tutorial but with fixes for current n8n version.14, 2025)

### Issue 1: Facebook Webhook Verification Not Working

**Problem:** The Respond to Webhook node wasn't executing (staying gray) when Facebook sent webhook verification requests.

**Root Cause:** The "Respond to Webhook" node was connected to the TRUE branch of an "If" node, but the verification data was going to the FALSE branch.

**Solution:** 
- Removed the If node from the verification flow
- Connected "Respond to Webhook" node directly to the Webhook node
- Configured Response Body to return: `{{ $('Webhook').item.json.query['hub.challenge'] }}`

**Result:** Webhook verification now works correctly. Facebook receives the challenge response and approves the webhook.

### Issue 2: HTTP Request Node - Invalid JSON Error

**Problem:** HTTP Request node throwing error: "JSON parameter needs to be valid JSON"

**Root Cause:** The AI Agent's output text contained unescaped quotes or special characters that broke the JSON structure when inserted into the message text field.

**Original Code (Broken):**
```json
{
  "recipient": {
    "id": "{{ $('Webhook').item.json.body.entry[0].messaging[0].sender.id }}"
  },
  "messaging_type": "RESPONSE",
  "message": {
    "text": "{{ $json.output }}"
  }
}
```

**Fixed Code:**
```json
{
  "recipient": {
    "id": "{{ $('Webhook').item.json.body.entry[0].messaging[0].sender.id }}"
  },
  "messaging_type": "RESPONSE",
  "message": {
    "text": {{ JSON.stringify($json.output) }}
  }
}
```

**Key Change:** Changed `"{{ $json.output }}"` to `{{ JSON.stringify($json.output) }}`

**Why This Works:** 
- `JSON.stringify()` properly escapes quotes, newlines, and special characters
- Prevents the AI output from breaking the JSON structure
- No longer needs surrounding quotes because stringify() returns a properly formatted JSON string

**Alternative Solution:** Use "Using Fields Below" instead of "Using JSON" in the Specify Body dropdown, which handles JSON encoding automatically.