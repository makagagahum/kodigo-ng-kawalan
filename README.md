🚀 Kodigo ng Kawalan
===================

**Likhâ sa Wala** | *Unix philosophy. Distributed systems. Layers all the way down.*

---

👋 Who I Am (And How I Got Here)
--------------------------------

Hey there. I'm **Marvin Villanueva** - a mechanical engineering student who became absolutely obsessed with tinkering, tweaking, and breaking things (then fixing them). Yeah, everything here is self-taught. No formal CS degree. Just curiosity, stubbornness, and a ridiculous amount of time down the Linux rabbit hole.

But real talk? My actual first love was **rooting**. I'm talking CWM days, back when flashing ROMs wasn't just a hobby - it was a lifestyle. I was bricking my phone like a crack addict, sometimes multiple times a day. And I wasn't trying to be trendy or impress anyone. I was trying to understand. To control. To own the device I held in my hand.

Then I got wild with it. Triple-booting Sailfish OS, Android, and Ubuntu Touch on a Xiaomi Mi 3? That was me. That's when everything changed.

### The Rabbit Hole That Started It All

That triple-boot pulled me into **Linux**. Hard. I didn't just use it - I rebuilt it from scratch.

I ended up running **Void Linux with Bedrock** (no systemd, thank you very much) on a modded ThinkPad X230 with 78MB RAM on startup. You read that right. Seventy-eight megabytes. I compiled my own kernel, built my GUI from absolute scratch, tweaked every single line. That's not software engineering - that's art. That's understanding your machine so completely that you become it.

Eventually, I stopped the daily rooting grind when **Shizuku** came around and **Termux** got seriously powerful. But I didn't stop tinkering. I started running rooted VMs inside Android. I compiled **Arch Linux with KDE through Termux X11** and just... lived there. Started writing my own automation scripts. Built a whole parallel universe inside Android.

Why? Because each layer I understood was another level of freedom. Another layer of control.

### What This Taught Me

That dive - that obsession - kickstarted my IT career. It taught me something crucial: **everything is layers**. Your hardware, your kernel, your filesystem, your application, your database, your network. Each layer has rules. Each layer has boundaries. And if you understand the layers, you can work with them instead of fighting them.

This insight became everything. When I moved to machine learning, data science, and pen testing - it was all the same: understanding the layers. Finding where they connect. Discovering what happens when you probe those connections.

### The Why Behind This

Now here's the thing: I could've charged $99/month for a managed platform that does what this does. I could've built a SaaS and extracted value. I didn't. Because I remember being that kid with a bricked phone and no AWS credits. I remember the desperation to build, to deploy, to prove it could work on zero budget.

I also understand something deeper. We're living in layers - society, economy, simulation, dimensions - and what you do in one layer affects all the others. Building infrastructure that's free, transparent, and yours to modify isn't charity. It's recognizing that access to tools shouldn't depend on your ability to pay.

I've been on psychedelics. I was an atheist, still skeptical of everything. I understand Unix philosophy because it works - it's not optimized for convincing investors, it's optimized for solving problems. There's something enlightened about that.

I feel like I'm on 8 dimensions, on a simulation. When you think about it that way, the goal isn't to extract maximum value and disappear. It's to leave things better than you found them.

So I'm paying it forward.

📝 One Person. Seven Roles. Infinite Possibilities.
---------------------------------------------------

This isn't just a tech stack. It's a philosophical approach to building infrastructure that works with entropy, not against it. Seven distinct responsibilities, each following its own Unix principle, unified into something that actually functions.

Instead of pretending one person is a "full-stack everything", here's what's actually happening:

| Role | Focus | Folder | Status |
|------|-------|--------|--------|
| 🤖 **Automation Engineer** | n8n workflows, task automation, API integrations | [/n8n](/n8n) | 🟢 Active |
| 🔒 **Cybersecurity Specialist** | DDoS protection, SSL/TLS, hardening, security configs | [/security-hardening](/security-hardening) | 🟢 Active |
| 💻 **Full-Stack Developer/Webmaster** | Bug fixes, performance, maintenance, deployment | [/bug-fixes](/bug-fixes) | 🟢 Active |
| 🐳 **DevOps Engineer** | Docker, Render deployment, infrastructure scaling | [/devops](/devops) | 🟢 Active |
| 🗄️ **Database Administrator** | PostgreSQL optimization, Supabase, connection pooling | [/database](/database) | 🟢 Active |
| 📧 **Email Administrator** | Mailu setup, mail.orin.work, email infrastructure | [/email](/email) | 🟢 Active |
| 🤖 **AI/ML Engineer** | ORIN AI agents, production setup, model optimization | [/ai-ml](/ai-ml) | 🟢 Active |

Each role has its own folder, its own documentation, its own identity. That's the point.

🗺️ Navigation Guide
--------------------

### Quick Start (5 minutes)

- 1. **Understand the architecture** → Read the [System Architecture](#-system-architecture) section below
- 2. **Explore automation workflows** → Check [`/n8n/README.md`](/n8n/README.md)
- 3. **Review security setup** → Check [`/security-hardening/README.md`](/security-hardening/README.md)
- 4. **See maintenance practices** → Check [`/bug-fixes/README.md`](/bug-fixes/README.md)

### For Different Audiences

**Just want to deploy?**

- Start with [System Architecture](#-system-architecture)
- Jump to [`/n8n/README.md`](/n8n) for deployment workflows

**Interested in security?**

- Head to [`/security-hardening/README.md`](/security-hardening/README.md)
- Covers DDoS protection, hardening guides, and SSL/TLS setup

**Need to fix something?**

- Check [`/bug-fixes/README.md`](/bug-fixes/README.md)
- Lists common issues, fix areas, and maintenance procedures

**Want the full story?**

- Continue reading below for the philosophy and architecture

🏗️ System Architecture
-----------------------

Why this architecture? Because it respects Unix principles. Each component does one thing well. They communicate cleanly. When one thing breaks, the others keep working.

### Three-Tier Distributed Architecture

The system is built on three layers - each optimizing for different concerns:

**Tier 1: Client & Content Delivery (Cloudflare)**

- Global DDoS Protection (bad actors stop here)
- Request Routing & Geographic Optimization (smart, not brute force)
- Static Content Caching (serve from everywhere instantly)
- SSL/TLS Encryption & Rate Limiting (defense, not walls)

**Tier 2: Application & Orchestration (Render)**

- n8n Automation Engine (containerized, portable)
- Auto-Scaling based on actual metrics (not guessing)
- Health checks and auto-restart (self-healing, not fragile)
- PostgreSQL connection pooling (efficiency, not waste)

**Tier 3: Data Persistence (Supabase/PostgreSQL)**

- Fully managed PostgreSQL with real-time capabilities
- Row-Level Security for data isolation (trust, not hope)
- Connection pooling & automated backups (redundancy that works)
- Point-in-time recovery (mistakes are recoverable)

```
┌──────────────────────────┐
│ USER REQUESTS │
│ (Via Your Custom Domain) │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────────────────┐
│ TIER 1: CLOUDFLARE EDGE NETWORK │
│ • Global DDoS Protection │
│ • SSL/TLS Encryption │
│ • Rate Limiting & Caching │
└────────────┬─────────────────────────┘
             │
             ▼
┌──────────────────────────────────────┐
│ TIER 2: RENDER (Application Layer) │
│ • n8n Automation Engine │
│ • Auto-Scaling & Load Balancing │
│ • Health Checks & Auto-Restart │
│ • PostgreSQL Connection Pooling │
└────────────┬─────────────────────────┘
             │
             ▼
┌──────────────────────────────────────┐
│ TIER 3: SUPABASE (Data Persistence) │
│ • PostgreSQL with Real-time APIs │
│ • Row-Level Security │
│ • Automated Backups & Recovery │
│ • Connection Pooling │
└──────────────────────────────────────┘
```

🎯 The Philosophy
-----------------

### Unix Philosophy Applied to Web Hosting

1. **Do one thing, do it well** - Each role has a clear focus. No overlap. No confusion.
2. **Composition over combination** - Separate tools talking to each other beats a monolithic everything.
3. **Expect the output of every role to become the input of another** - Documentation flows, automation triggers, data propagates.
4. **Transparency and openness** - No black boxes. No vendor lock-in more than necessary.
5. **Understand the layers** - When you know how systems connect, you can predict failure and prevent it.

I built this because I remember being broke, wanting to deploy something real without AWS charging me $1,400/month for auto-scaling I don't need. I remember forums full of people asking "Can I do this for free?"

The answer is yes. And it's not a compromise.

### The Infrastructure Principles

So this infrastructure is built to be:

- **Cheap** - Your money doesn't disappear into corporate cloud bills
- **Maintainable** - Future you won't hate current you when something breaks
- **Documented** - Anyone can understand what's happening (including future you)
- **Scalable** - When you grow, it grows with you without reinvention
- **Open** - Open source, open principles, open to modification
- **Resilient** - It fails gracefully, not catastrophically

The philanthropic end goal: infrastructure shouldn't be a barrier to good ideas.

📚 The Deep Dive
----------------

For comprehensive documentation on each specialization:

- **n8n Automation**: See [`/n8n/README.md`](/n8n/README.md) for workflows, use cases, and setup
- **Security Hardening**: See [`/security-hardening/README.md`](/security-hardening/README.md) for DDoS protection, SSL/TLS, and hardening guides
- **Bug Fixes & Maintenance**: See [`/bug-fixes/README.md`](/bug-fixes/README.md) for common issues, fix areas, and maintenance tasks

Each section explains:

- Why this choice (not just "use X because")
- How to optimize for your use case
- Common failures and how to prevent them
- Security considerations that actually matter (not marketing)

📦 The Stack
------------

**Compute:** Render (free tier + paid when you need it)
**Database:** Supabase (PostgreSQL that actually works)
**CDN/WAF:** Cloudflare (Workers for serverless, routing for speed)
**Automation:** n8n (Open source, self-hosted, not a subscription trap)
**Email:** Mailu (Open source email infrastructure, yours to modify)

Each choice based on:

- Not being dependent on one company's goodwill
- Actually owning your data and infrastructure
- Reasonable pricing that scales with you, not against you
- Actual technical merit (not just "popular")
- Understanding how each layer works

🔗 Let's Connect
----------------

- **GitHub:** [@makagagahum](https://github.com/makagagahum)
- **Issues/Questions:** Open a GitHub issue. I actually respond.
- **Improvements:** PRs welcome. This is open source for a reason.

Built with the belief that good infrastructure is both possible and necessary.

Run it yourself. Modify it. Make it yours.
Then help someone else do the same.
