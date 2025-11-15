# ORIN AI - Deployment Guide (For Everyone)

> **⚠️ IMPORTANT:** `orin.work` is a sample domain used in this guide. **Replace it with YOUR OWN DOMAIN** throughout these instructions. ORIN AI is an n8n-powered AI agent workflow running on this infrastructure.

## 🚀 Option 1: Auto-Deploy (Easiest - No Script Needed)

Edit `index.html` directly on GitHub:

1. Go to: `index.html` in this repo
2. Click the pencil icon (Edit)
3. Make your changes
4. Scroll down and click "Commit changes"
5. Wait 1-2 minutes
6. Changes live on `https://YOUR-DOMAIN.com` (replace with your actual domain)

**How it works:**
- GitHub → Render (auto pulls) → Cloudflare (CDN) → YOUR-DOMAIN.com
- No script needed. Automatic.

---

## 📝 Option 2: Use Deploy Script (For Developers)

If you want to work locally:

### Mac/Linux:

```bash
bash <(curl -s https://raw.githubusercontent.com/0mnisciux/orin-ai-production/main/deploy.sh)
```

### What it does:

- Clones repo to your computer
- Pulls latest changes
- Shows you next steps
- That's it

Then:

```bash
cd orin-ai-production
edit index.html          # Edit in your editor
git add index.html
git commit -m "Update"
git push origin main
```

---

## ⏱️ Timeline

| Action | Time |
|--------|------|
| Edit + Commit | Instant |
| Render redeploy | 5-10 sec |
| Cloudflare cache | ~1 min |
| Live on YOUR-DOMAIN.com | 1-2 min total |

---

## 💰 Cost

**$0** - Everything stays free forever

- GitHub (free tier)
- Render (free tier)
- Cloudflare (free tier)
- Domain only (purchased separately)

---

## 🤖 What is ORIN AI?

**ORIN AI** is an intelligent automation agent built with **n8n** that powers your business workflows. It's deployed on this infrastructure and can:

- Automate repetitive tasks
- Integrate with external services
- Provide intelligent responses via webhooks
- Run scheduled workflows
- Process data in real-time

The `index.html` you edit here is the frontend interface for interacting with ORIN AI. You can customize its appearance and behavior directly by modifying the HTML, CSS, and JavaScript in this file.

---

## 🔧 Domain Setup

### How to Use Your Own Domain:

1. **Purchase a domain** (e.g., from Namecheap, GoDaddy, etc.)
2. **Update Cloudflare DNS** to point to your Render deployment
3. **Update this guide** - Replace `orin.work` and `YOUR-DOMAIN.com` with your actual domain name
4. **Update any hardcoded URLs** in `index.html` that reference the domain

### Example: If Your Domain is `myagent.com`

- Replace `https://orin.work` → `https://myagent.com`
- Replace `YOUR-DOMAIN.com` → `myagent.com`
- Update any API endpoints in index.html to use `https://myagent.com/webhook/...`

---

## ❓ FAQ

**Q: Can a non-technical person deploy this?**
A: Yes. Option 1 (edit on GitHub) requires zero setup.

**Q: Where does my code live?**
A: GitHub repo + Render servers + Cloudflare CDN

**Q: Will it always be free?**
A: Yes. Free-tier limits are huge for small projects.

**Q: How do I customize the design?**
A: Edit colors/text in `index.html` and commit.

**Q: Do I need to know Git?**
A: No. Option 1 needs zero Git knowledge.

**Q: What if I want to modify n8n workflows (ORIN AI)?**
A: Access your n8n instance directly. The workflows are separate from this HTML interface. Changes to `index.html` only update the frontend.

**Q: How do I connect ORIN AI to external services?**
A: ORIN AI runs on n8n, which supports 700+ integrations. Configure these directly in your n8n dashboard.

---

## 🚨 CRITICAL FIX: package.json Breaking Static Site Deployment

### The Issue

If your Render static site deployment keeps failing with `npm error code TARGET` or `npm error code ERESOLVE`, the culprit is likely a `package.json` file in your repository.

**Why?** Render detects `package.json` and automatically assumes your project is a Node.js application, triggering npm install and build processes. For pure static HTML sites, this causes build failures because:

- There's no build script to run
- Dependencies can't be resolved for a static-only site
- Render tries to execute npm commands on non-existent scripts

### The Solution

**DELETE the `package.json` file** if your site is purely static HTML/CSS/JS.

**Steps:**

1. Go to your GitHub repo
2. Find and open `package.json`
3. Click the three-dot menu → "Delete file"
4. Commit the deletion with message: "Delete package.json - static site only"
5. Trigger a manual deploy on Render Dashboard
6. ✅ Deployment should now succeed

### Why This Works

Once `package.json` is deleted, Render correctly identifies your project as a **static site** and:
- Skips npm dependency resolution
- Directly serves files from the Public Directory (default: `./`)
- No build process needed
- Deployment completes in seconds

### Timeline Example

**Before Fix:**
- ❌ Deploy failed with npm errors
- ❌ Multiple failed attempts
- ❌ "Exited with status 1 while building your code"

**After Fix:**
- ✅ Deploy live for [commit hash]: Delete package.json - static site only
- ✅ Zero-downtime deployment
- ✅ Site immediately live at YOUR-DOMAIN.com

### Key Takeaway

**For static-only sites: Keep your repo clean of build configuration files** (`package.json`, `gulpfile.js`, `webpack.config.js`, etc.) to let Render serve static assets directly without attempting compilation.

---

## 📞 Key Takeaway

**For static-only sites: Keep your repo clean of build configuration files** (`package.json`, `gulpfile.js`, `webpack.config.js`, etc.) to let Render serve static assets directly without attempting compilation.

---

## 🆘 Questions?

Check the README or deployment logs on Render.
