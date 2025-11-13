# ORIN AI - Deployment Guide (For Everyone)

## 🚀 Option 1: Auto-Deploy (Easiest - No Script Needed)

Edit `index.html` directly on GitHub:

1. Go to: `index.html` in this repo
2. Click the pencil icon (Edit)
3. Make your changes
4. Scroll down and click "Commit changes"
5. Wait 1-2 minutes
6. Changes live on https://orin.work

**How it works:**
- GitHub → Render (auto pulls) → Cloudflare (CDN) → orin.work
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

## Timeline

| Action | Time |
|--------|------|
| Edit + Commit | Instant |
| Render redeploy | 5-10 sec |
| Cloudflare cache | ~1 min |
| Live on orin.work | 1-2 min total |

---

## Cost

**$0** - Everything stays free forever

- GitHub (free tier)
- Render (free tier)
- Cloudflare (free tier)
- Namecheap (domain only)

---

## FAQ

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

---

Questions? Check the README or deployment logs on Render.
