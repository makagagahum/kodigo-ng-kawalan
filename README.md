# Kodigo ng Kawalan 👁️

**Likha sa Wala** | Unix philosophy. Distributed systems. Layers all the way down.

> This is a manifesto. Not just tech documentation.
>
> ---

## 🚀 Quick Start - Copy & Paste Scripts

### PowerShell (Windows)
```powershell
iex "(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/makagagahum/kodigo-ng-kawalan/main/kodigo-for-dummies/setup.ps1')"
```

### Bash (macOS / Linux)
```bash
curl -fsSL https://raw.githubusercontent.com/makagagahum/kodigo-ng-kawalan/main/kodigo-for-dummies/auto-setup.sh | bash
```

### Termux (Android Terminal)
```bash
curl -fsSL https://raw.githubusercontent.com/makagagahum/kodigo-ng-kawalan/main/kodigo-for-dummies/auto-setup.sh | bash
```
**Full guide**: See `likha-android/TERMUX-SETUP.md`

### Android App (LIKHA.apk)
Download `likha-v1.apk` from [Releases](https://github.com/makagagahum/kodigo-ng-kawalan/releases)
- Install on device
- Tap LIKHA to launch
- Terminal opens, OAuth flows auto-start

---



## This Is a Manifesto

I'm here, not as a faceless engineer, but as someone who's torn open the layers of technology, philosophy, and whatever-the-hell existence means in this simulation. If you came looking for dull, sanitized instructions, close the tab. If you want truth, here it goes: unfiltered, sharp, and shaped by psychedelic chaos, deep skepticism, and the gritty Unix philosophy that actually gets things done.

**Kodigo ng Kawalan** isn't just tech documentation. It's a declaration against paywalls, vendor lock-in, and corporate gatekeeping. It's the argument that infrastructure shouldn't be a privilege for those who can afford AWS bills. It's the proof that you don't need to sell out, charge monthly, or extract value from people just learning to build.

Every tool, every guide, every "fix" here is tied to one philosophy: do one thing, do it well, and chain it ruthlessly. Automation, security, scaling, resilience. These aren't just features. They're survival strategies. They're weapons against chaos. Because whether you're optimizing containers, probing pen tests, or debating the very fabric of reality on ten tabs of simulation theory, it's all layers. Master the layers, and you master the game.

This isn't about me. It's about what happens when you refuse to compromise. When you understand that freedom isn't granted, it's seized. That control comes from understanding each layer so completely you become indistinguishable from it.

I'm Marvin. This is what I believe. This is what works. This is what I'm building, sharing, and asking you to improve.

---

## One Person. Eight Roles. Infinite Possibilities.

This isn't just a tech stack. It's a philosophical approach to infrastructure that works with entropy instead of against it. Eight distinct roles, each following Unix principles, unified into something functional.

| Role | Daily USD | Daily PHP | Folder |
| --- | --- | --- | --- |
| **Automation Engineer** | $21-$43 | ₱1,232-₱2,464 | [/n8n](/n8n) |
| **Cybersecurity Specialist** | $27-$60 | ₱1,560-₱3,480 | [/security-hardening](/security-hardening) |
| **Full-Stack Developer** | $25-$52 | ₱1,450-₱3,016 | [/bug-fixes](/bug-fixes) |
| **DevOps Engineer** | $29-$63 | ₱1,680-₱3,640 | Infrastructure as Code |
| **Database Administrator** | $25-$49 | ₱1,450-₱2,842 | [Database Layer](/docs) |
| **Email Administrator** | $23-$41 | ₱1,334-₱2,378 | [Email Layer](/docs) |
| **AI/ML Engineer** | $35-$67 | ₱2,030-₱3,886 | [/orin-revamp](/orin-revamp) |
| **AI Personality Architect** | $20-$40 | ₱1,160-₱2,320 | [/ai-personality-architect](/ai-personality-architect) |
| **NCR Minimum-Wage Worker (non‑agri) | $11–$12 | ₱645–₱695 | Legal floor, Metro Manila baseline |
| Provincial Minimum-Wage Worker | ~$8–$10 | ~₱400–₱500 | Typical provincial baseline (varies by region) |



Each role has its own folder, its own documentation, its own identity. Each one follows the principle: **do one thing well**.

## The Foundation: Rooted in Obsession

Understanding infrastructure requires understanding obsession. Real obsession. The kind that makes you brick your phone repeatedly not because you're reckless, but because you're trying to understand. To control. To own the device in your hand.

I started with rooting. CWM days. ROM flashing. That was the first taste of understanding layers: the bootloader, the kernel, the filesystem, the application. Each layer controlling the next. Each layer opening doors if you understood it.

Then it escalated. Triple-booting Sailfish OS, Android, Ubuntu Touch on a Xiaomi Mi 3. Running Void Linux with Bedrock on a modded ThinkPad X230 with 78MB RAM. Compiling my own kernel from scratch. Building my GUI from absolute zero. That's not a hobby. That's a philosophy. That's understanding your machine so completely that it becomes an extension of your will.

Eventually, rooting the device wasn't enough. So I built a whole parallel universe inside Android. Running rooted VMs. Compiling Arch Linux with KDE through Termux X11. Writing automation scripts. Building systems within systems. Each one a layer of freedom. Each one a layer of control.

Why? Because every layer you understand is another level of independence. Another layer of power.

---

## What This Taught Me: Everything Is Layers

This obsession led to a realization that became everything: **everything is layers**. Your hardware. Your kernel. Your filesystem. Your application. Your database. Your network. Your society. Your economy. Your consciousness.

Each layer has rules. Each layer has boundaries. And if you understand the layers, if you understand how they connect and where they overlap, you can work with them instead of fighting them. You can predict failure. You can prevent catastrophe. You can build systems that don't just survive entropy, they work with it.

When I moved to machine learning, data science, pen testing, it was the same principle: understanding the layers. Finding where they connect. Discovering what happens when you probe those connections. When you understand a system at every level, you own it.

This insight is the foundation of everything here.

---

## System Architecture

Why this architecture? Because it respects Unix principles. Each component does one thing well. They communicate cleanly. When one thing breaks, the others keep working. It fails gracefully, not catastrophically.

### Three-Tier Distributed Architecture

Three layers, each optimizing for different concerns:

**Tier 1: Client & Content Delivery (Cloudflare)**
- Global DDoS Protection (bad actors stop here)
- Request Routing & Geographic Optimization (smart distribution)
- Static Content Caching (serve from everywhere instantly)
- SSL/TLS Encryption & Rate Limiting (defense that works)

**Tier 2: Application & Orchestration (Render)**
- n8n Automation Engine (containerized, portable, yours)
- Auto-Scaling based on actual metrics (not guessing)
- Health checks and auto-restart (self-healing systems)
- PostgreSQL connection pooling (efficiency, not waste)

**Tier 3: Data Persistence (Supabase/PostgreSQL)**
- Fully managed PostgreSQL with real-time capabilities
- Row-Level Security for data isolation (trust, not hope)
- Connection pooling & automated backups (redundancy that works)
- Point-in-time recovery (mistakes are recoverable)

---

## Navigation Guide

### Quick Start (5 minutes)

1. **Understand the architecture** - Read System Architecture above
2. **Explore automation workflows** - Check `/n8n/README.md`
3. **Review security setup** - Check `/security-hardening/README.md`
4. **See maintenance practices** - Check `/bug-fixes/README.md`
5. **Learn AI Personality Design** - Check `/ai-personality-architect/README.md`

### For Different Audiences

**Just want to deploy?**
- Start with System Architecture above
- Jump to `/n8n/README.md` for deployment workflows

**Interested in security?**
- Head to `/security-hardening/README.md`
- Covers DDoS protection, hardening, SSL/TLS setup

**Need to fix something?**
- Check `/bug-fixes/README.md`
- Lists common issues, fixes, maintenance procedures

**Want to build AI agents?**
- Go to `/ai-personality-architect/README.md`
- Learn how to encode human personality into AI

---

## The Philosophy: Unix Applied to Infrastructure

1. **Do one thing, do it well** - Each role has singular focus. No overlap. No confusion.
2. **Composition over monolith** - Separate tools talking cleanly beats everything jammed together.
3. **Output flows to input** - Documentation triggers automation. Automation triggers monitoring. Everything connects.
4. **Transparency and openness** - No black boxes. No mysterious vendor lock-in beyond what's necessary.
5. **Understand the layers** - Know how systems connect. Predict failure. Prevent catastrophe.

### Infrastructure Principles

This system is built to be:

- **Cheap** - Your money doesn't disappear into corporate clouds
- **Maintainable** - Future you won't hate current you when things break
- **Documented** - Anyone can understand what's happening
- **Scalable** - Growth doesn't require reinventing everything
- **Open** - Open source, open principles, open to modification
- **Resilient** - It fails gracefully, not catastrophically

The end goal: **infrastructure shouldn't be a barrier to good ideas.**

---

## The Deep Dive

For comprehensive documentation:

- **n8n Automation** - See `/n8n/README.md` for workflows, use cases, setup
- **Security Hardening** - See `/security-hardening/README.md` for DDoS, SSL/TLS, hardening
- **Bug Fixes & Maintenance** - See `/bug-fixes/README.md` for issues, fixes, maintenance
- **AI Personality Architecture** - See `/ai-personality-architect/README.md` for building sentient agents
- **Documentation Structure** - See `/docs/README.md` for how docs are organized

Each explains:

- Why this choice (not just "use X because")
- How to optimize for your case
- Common failures and prevention
- Security that actually matters

---

## The Stack

**Compute:** Render (free tier, paid when needed)
**Database:** Supabase (PostgreSQL that actually works)
**CDN/WAF:** Cloudflare (Workers for serverless, routing for speed)
**Automation:** n8n (Open source, self-hosted, not a subscription trap)
**Email:** Mailu (Open source email, yours to modify)
**Frontend:** React 19 + TypeScript + Vite (Modern, performant, free)

Each choice based on:

- Not dependent on one company's goodwill
- You own your data and infrastructure
- Pricing scales with you, not against you
- Technical merit, not just popularity
- Understanding how each layer works

---

## Reach Out

Got questions? Found something broken? Want to build on top of this?

Hit me up directly:

- **Email:** marvin@orin.work
- **GitHub:** Open an issue, contribute, make it yours
- **Orin AI:** Visit https://orin.work/ or https://www.facebook.com/orinworks

---

## Let's Go

It's free. It works. Use it.

Transform it. Share it. Pass it forward.


## Salary Data

📊 **AI Job Salaries for Manila (Updated Daily)**

See detailed salary data for all 8 roles in the [`/data`](./data) folder. Updated automatically daily with current market rates (USD & PHP) and hourly breakdowns.

**View raw data:** [`data/salary-data.json`](./data/salary-data.json)
---

## Kodigo for Dummies: A Layman's Guide

**Lost? Don't understand all the tech jargon?** This section is for you! Let's break down what this project is actually about in simple terms.

### What is Kodigo ng Kawalan?

Think of **Kodigo ng Kawalan** ("Code of Nothing/Void") as a **DIY instruction manual for building your own tech empire without spending money on big companies.**

Instead of paying Amazon, Google, or Microsoft thousands of dollars per month to host your website or run your apps, this project shows you how to use **free and cheap tools** to do the same thing yourself.

### The Simple Analogy: Building Your House

Imagine you want to build a house:

- **The Old Way (Expensive)**: You hire a contractor who owns everything. You pay him rent every month. If he decides to raise prices or shut down, you're homeless.

- **The Kodigo Way (Cheap & Free)**: You learn to build it yourself using free materials. You understand every wall, every floor, every roof. You own it all. Nobody can take it away.

### What Does This Project Actually Do?

1. **Automates Work** (`n8n` - Automation Layer)
   - Imagine a robot that does repetitive tasks for you 24/7
   - Updates data, sends emails, posts on social media - all automatically
   - You define the rules once, it works forever

2. **Protects Your Website** (Cloudflare - Security Layer)
   - Like a security guard blocking bad people from entering your house
   - Stops hackers, handles millions of visitors without crashing
   - Super fast because it's spread worldwide

3. **Stores Your Data Safely** (Supabase/PostgreSQL - Data Layer)
   - Think of it as a smart filing cabinet that organizes everything
   - You can ask it questions: "Show me all users from Manila" and it answers in milliseconds
   - Data is backed up so you never lose anything

4. **Runs Your Code** (Render - App Server Layer)
   - This is where your actual website/app lives and runs
   - Like a shopkeeper running a store 24/7

### The 8 Roles Explained

One person (Marvin) does all these jobs by learning:

| Job | What It Means | Why It Matters |
|-----|---------------|----------------|
| **Automation Engineer** | Sets up robots to do work | Nobody has to do boring tasks |
| **DevOps Engineer** | Keeps everything running smoothly | Website never crashes |
| **Security Specialist** | Protects from hackers | Your data stays safe |
| **Full-Stack Developer** | Builds the actual website/app | People can use your service |
| **Database Admin** | Organizes all the data | Information is organized & fast |
| **AI/ML Engineer** | Makes smart systems | Chatbots, predictions, automation |
| **Email Admin** | Manages email servers | You send/receive emails directly |
| **AI Personality Architect** | Teaches AI to "think" like you | Your AI actually behaves right |

### The Salary Comparison

The salary table shows:

- **Tech roles in Manila**: $21-$67 per day
- **Average worker in Philippines**: $11-$12 per day (NCR) or ~$8-$10 (provinces)

**What this means**: These tech skills can earn you **3-6x more** than traditional jobs. Learn these skills, and you can change your life.

### What's the Goal?

**Simple**: Build systems that work automatically, don't cost much, and you fully control.

Instead of:
- Paying $1,000/month to Amazon for hosting
- Paying $500/month to Facebook for ads
- Hiring 5 people to do repetitive work

You use free tools + a little coding and automation to do it all yourself.

### Who Should Care About This?

1. **Tech enthusiasts** - Want to learn how real infrastructure works
2. **Developers** - Want to build without paying corporations
3. **Business owners** - Want to save money on tech costs
4. **Students** - Want to understand how the internet actually works
5. **Anyone curious** - Wondering what all these "layers" and "automation" really mean

### The Honest Truth

This project proves: **You don't need to be rich to build big things.** You need to:

1. Understand the layers
2. Learn the tools
3. Connect them together
4. Keep improving

That's it. No magic. Just layers, Unix philosophy, and obsession.

---

**Still confused?** Email me at [marvin@orin.work](mailto:marvin@orin.work) with your question. I'll explain it in even simpler terms.
