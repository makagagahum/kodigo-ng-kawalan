# Hugging Face n8n Deployment Setup

## Overview
Comprehensive documentation for deploying n8n on Hugging Face Spaces with custom domain configuration and uptime monitoring.

**Date:** December 5, 2025  
**Setup By:** makagagahum  
**Stack:** Hugging Face Spaces, Cloudflare DNS, UptimeRobot

---

## Deployment Architecture

### Components
1. **Hugging Face Space**: `orinai-n8n.hf.space`
   - Free CPU Basic tier (2 vCPU, 16 GB RAM, 50 GB disk)
   - Running n8n workflow automation
   - Connected to Supabase PostgreSQL (free tier)

2. **Custom Domain**: `n8n.orin.work`
   - Managed via Cloudflare DNS
   - CNAME record pointing to HF Space

3. **Uptime Monitoring**: UptimeRobot
   - 5-minute interval checks
   - Prevents HF Space from sleeping
   - Email notifications enabled

---

## Step 1: Hugging Face Space Setup

### Initial Configuration
```bash
# Space Details
Space Name: orinai-n8n
Visibility: Private
Hardware: CPU basic (free)
URL: https://orinai-n8n.hf.space
```

### Environment Variables
Configured in HF Space settings:
```
DB_POSTGRESDB_HOST=<supabase-host>
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=postgres
DB_TYPE=postgresdb
DB_POSTGRESDB_SCHEMA=public
WEBHOOK_URL=https://orinai-n8n.hf.space
N8N_EDITOR_BASE_URL=https://orinai-n8n.hf.space
```

### Keep-Alive Strategy
- HF Spaces sleep after ~48 hours of inactivity
- Solution: UptimeRobot monitoring every 5 minutes
- Alternative: GitHub Actions cron job

---

## Step 2: Cloudflare DNS Configuration

### Domain: orin.work
**Account:** Omniscius  
**Management:** https://dash.cloudflare.com

### DNS Record Created
```
Type: CNAME
Name: n8n
Target: orinai-n8n.hf.space
Proxy Status: DNS only (grey cloud)
TTL: Auto
```

### Steps to Update DNS
1. Navigate to Cloudflare Dashboard
2. Select `orin.work` domain
3. Go to DNS > Records
4. Click existing `n8n` record or create new
5. Set Type: CNAME
6. Set Target: `orinai-n8n.hf.space`
7. Keep Proxy Status as "DNS only"
8. Save changes

### DNS Propagation
- Typical time: 5-15 minutes
- Can take up to 24-48 hours globally
- Check status: `dig n8n.orin.work` or online DNS checkers

---

## Step 3: UptimeRobot Monitoring

### Monitor Configuration
```
Monitor Name: orinai-n8n.hf.space
Monitor Type: HTTP(S)
URL: https://orinai-n8n.hf.space
Monitoring Interval: 5 minutes
Notifications: Email (orin.ai420@gmail.com)
Status: Active
```

### Dashboard
https://dashboard.uptimerobot.com/monitors

### Current Monitors (5/50 used)
1. marvin-resume-backend.onrender.com (DOWN)
2. orinai-n8n.hf.space (UP - 99.97%)
3. marvin-resume.onrender.com (UP - 98.58%)
4. orin-revamp.vercel.app (UP - 100%)
5. orin.work (UP - 100%)

### Benefits
- Prevents HF Space from sleeping
- Real-time downtime alerts
- 99.97% uptime tracking
- Free tier: 50 monitors

---

## Access Points

### Primary URLs
- **HF Direct**: https://orinai-n8n.hf.space
- **Custom Domain**: https://n8n.orin.work (after DNS propagation)

### Admin Access
- **HF Space Settings**: https://huggingface.co/spaces/orinai/n8n/settings
- **Cloudflare DNS**: https://dash.cloudflare.com/64d8191651a5a83b26cba4140bb30827/orin.work/dns/records
- **UptimeRobot**: https://dashboard.uptimerobot.com/monitors

---

## Performance Optimization

### n8n Configuration Tips
```env
# Execution mode for low latency
EXECUTIONS_PROCESS=main

# Timeout configuration
EXECUTIONS_TIMEOUT=300

# For queue mode with Redis
QUEUE_BULL_REDIS_HOST=<upstash-redis-url>
QUEUE_BULL_REDIS_TIMEOUT_THRESHOLD=20000
```

### Response Time Targets
- Simple workflows: 0.5-1 second
- Complex workflows: 2-5 seconds
- Key: Minimize HTTP hops, cache results

### Redis Integration (Optional)
- **Provider**: Upstash (serverless, free tier)
- **Use Case**: Queue mode, caching, worker coordination
- **Setup**: Add Redis env vars to HF Space

---

## Troubleshooting

### HF Space Went to Sleep
**Symptoms:**
- orinai-n8n.hf.space returns error or loading screen
- UptimeRobot shows DOWN status

**Solution:**
1. Visit https://orinai-n8n.hf.space directly
2. Wait 30-60 seconds for Space to wake up
3. Verify UptimeRobot monitor is active
4. Check monitor interval is set to 5 minutes

### DNS Not Resolving
**Check:**
```bash
dig n8n.orin.work
nslookup n8n.orin.work
```

**Expected Result:**
```
n8n.orin.work. 300 IN CNAME orinai-n8n.hf.space.
```

**If not working:**
- Wait longer (up to 24 hours)
- Clear DNS cache: `ipconfig /flushdns` (Windows) or `sudo dscacheutil -flushcache` (Mac)
- Check Cloudflare DNS settings

### Workflows Not Executing
1. Check Supabase PostgreSQL connection
2. Verify environment variables in HF Space settings
3. Check n8n logs in HF Space
4. Restart Space if needed

---

## Maintenance

### Regular Tasks
- **Weekly**: Check UptimeRobot status
- **Monthly**: Review HF Space usage/storage
- **Quarterly**: Update n8n version if needed

### Monitoring Checklist
- [ ] UptimeRobot monitors are green
- [ ] DNS resolves correctly
- [ ] n8n workflows are executing
- [ ] Supabase connection is stable
- [ ] No HF Space storage issues

### Backup Strategy
- **Workflows**: Export from n8n UI regularly
- **Database**: Supabase has automatic backups
- **Config**: Document env vars in this repo

---

## Cost Analysis

### Current Stack (100% Free)
| Service | Tier | Cost | Limits |
|---------|------|------|--------|
| Hugging Face Space | CPU Basic | $0 | 2 vCPU, 16GB RAM, 50GB disk |
| Supabase PostgreSQL | Free | $0 | 500MB DB, 2GB bandwidth/month |
| Cloudflare DNS | Free | $0 | Unlimited DNS queries |
| UptimeRobot | Free | $0 | 50 monitors, 5-min intervals |
| **Total** | | **$0/month** | |

### Scalability Options
- **HF Spaces**: Upgrade to paid tier for always-on
- **Supabase**: Pro tier ($25/mo) for 8GB DB
- **Upstash Redis**: Free tier → Pro for higher limits

---

## References

### Official Documentation
- [Hugging Face Spaces](https://huggingface.co/docs/hub/spaces)
- [n8n Documentation](https://docs.n8n.io/)
- [Cloudflare DNS](https://developers.cloudflare.com/dns/)
- [UptimeRobot](https://uptimerobot.com/)

### Related Docs in This Repo
- `docs/n8n/N8N_WEBHOOK_SETUP.md`
- `docs/TECH_STACK.md`
- `docs/RENDER_DEPLOYMENT.md`

---

## Changelog

### 2025-12-05
- ✅ Deployed n8n on HF Space (orinai-n8n.hf.space)
- ✅ Configured Supabase PostgreSQL connection
- ✅ Set up Cloudflare DNS (n8n.orin.work)
- ✅ Added UptimeRobot monitoring (5-min intervals)
- ✅ Documented complete setup process

---

## Support

**Issues?** Open an issue in this repo or check:
- HF Space logs
- Cloudflare DNS status
- UptimeRobot alerts
- Supabase connection status

**Contact:** orin.ai420@gmail.com
