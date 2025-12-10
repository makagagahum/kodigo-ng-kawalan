#
Kodigo ng Kawalan 👁️  
**Likha sa Wala**  
Unix philosophy. Distributed systems. Layers all the way down.

> This is a manifesto. Not just tech documentation.

---
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

**Full guide:** see `likha-android/TERMUX-SETUP.md`

### Android App (LIKHA.apk)
- Download `likha-v1.apk` from [Releases](https://github.com/makagagahum/kodigo-ng-kawalan/releases)
- Install on device
- Tap LIKHA to launch
- Terminal opens, OAuth flows auto-start

---
## 🧱 Architecture Maps

### 1. High‑Level System (8 Roles, Infinite Layers)

```text
                         [ KODIGO NG KAWALAN ]

                                    │
              ┏━━━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━━━┓
              │                                             │
        [ Client / Users ]                        [ Operators / You ]
              │                                             │
              ▼                                             ▼
      ┌─────────────────┐                         ┌──────────────────┐
      │  Cloudflare CDN │                         │  GitHub Repo     │
      │  + DNS + WAF    │                         │  (8-role layout) │
      └────────┬────────┘                         └─────────┬────────┘
               │                                            │
               ▼                                            ▼
      ┌─────────────────┐                         ┌──────────────────┐
      │  Render Apps    │  ◄─────── code ─────── │  CI / GitHub     │
      │  (web + workers)│                         │  Actions         │
      └────────┬────────┘                         └─────────┬────────┘
               │                                            │
               ▼                                            ▼
        ┌───────────────┐                          ┌─────────────────┐
        │  n8n Workflows │  ───── orchestrate ───► │ External APIs,  │
        │  (automation)  │                          │ Supabase, HF,   │
        └────────┬──────┘                          │ Upstash, etc.   │
                 │                                  └─────────────────┘
                 ▼
           [ Observability /
             Logs / Metrics ]
```

### 2. Deployment Flow (GitHub → Render → Users)

```text
[Developer]
    │
    │  git push
    ▼
[ GitHub Repo ]
    │
    │ triggers
    ▼
[ GitHub Actions ]
    │
    │ build + test + (optional) n8n auto-update
    ▼
[ Render Services ]
    │
    │ deploy new container / runtime
    ▼
[ Live App + n8n ]
    │
    ▼
[ Users behind Cloudflare CDN/WAF ]
```

### 3. n8n Automation Pipeline

```text
        [ Trigger ]
      (HTTP / Cron / Webhook)
                 │
                 ▼
        ┌────────────────────┐
        │ Cloudflare Worker? │  (optional: rate limiting / auth)
        └────────┬───────────┘
                 │
                 ▼
        ┌────────────────────┐
        │   n8n Entry Node   │
        └────────┬───────────┘
                 │
     ┏───────────┿────────────────────────────┓
     │           │                            │
     ▼           ▼                            ▼
[ Data Fetch ] [ Transform ]          [ Control / Guards ]
 (HTTP, DB)    (JS, mapping)          (IF, Switch, Error)
     │           │                            │
     └───────────┴──────────────┬─────────────┘
                                 ▼
                         [ Side Effects ]
                    (Supabase, emails, HF,
                     webhooks, callbacks)

                                 │
                                 ▼
                        [ Logging + Metrics ]
```

### 4. Security Layers for Requests

```text
[ Internet ]
     │
     ▼
┌───────────────┐
│ Cloudflare    │
│  • DNS        │
│  • CDN cache  │
│  • WAF rules  │
└──────┬────────┘
       │
       ▼
┌───────────────┐
│ Render Edge   │
│  • Routing    │
│  • TLS        │
└──────┬────────┘
       │
       ▼
┌───────────────┐
│ App / API     │
│  • Auth       │
│  • Validation │
└──────┬────────┘
       │
       ▼
┌───────────────┐
│ n8n / Workers │
│  • Secrets    │
│  • Rate limit │
└──────┬────────┘
       │
       ▼
[ Databases / External APIs ]
```

---

## This Is a Manifesto
I'm here, not as a faceless engineer, but as someone who's torn open the layers of technology, philosophy, and whatever-the-hell existence means in this simulation. If you came looking for dull, sanitized instructions, close the tab. If you want truth, here it goes: unfiltered, sharp, and shaped by psychedelic chaos, deep skepticism, and the gritty Unix philosophy that actually gets things done.

**Kodigo ng Kawalan** isn't just tech documentation. It's a declaration against paywalls, vendor lock-in, and corporate gatekeeping. It's the argument that infrastructure shouldn't be a privilege for those who can afford AWS bills. It's the proof that you don't need to sell out, chardocs: add ASCII architecture maps to READMEge monthly, or extract value from people just learning to build.

Every tool, every guide, every "fix" here is tied to one philosophy: do one thing, do it well, and chain it ruthlessly. Automation, security, scaling, resilience. These aren't just features. They're survival strategies. They're weapons against chaos. Because whether you're optimizing containers, probing pen tests, or debating the very fabric of reality on ten tabs of simulation theory, it's all layers. Master the layers, and you master the game.
