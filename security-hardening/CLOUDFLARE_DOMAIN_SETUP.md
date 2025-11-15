# Cloudflare Domain Binding: The Gateway Layer

## Doctrine: Your Domain as Territory

A domain isn't just a name. It's your territory. Your claim on the internet. When attackers own the DNS layer, they own you. When you own it, you're free.

This guide connects orin.work through Cloudflare. Not because it's mandatory. Because it's the minimum defense.

**Domain:** orin.work
**Guardian:** Cloudflare (Free Tier)
**Connected To:** Render.com deployment
**Doctrine Established:** November 2025

---

## The Gateway Stack

1. **Prerequisites** - What you need before entering this layer
2. **Step 1: Claim Your Domain in Cloudflare** - Add the territory
3. **Step 2: Update Nameservers** - Transfer control of DNS
4. **Step 3: Configure DNS Records** - Draw the traffic lines
5. **Step 4: SSL/TLS Configuration** - Encrypt the flow
6. **Step 5: Connect to Render** - Link application to domain
7. **Verification** - Confirm everything flows correctly
8. **Troubleshooting** - When layers break

---

## Prerequisites: Before You Begin

You need these layers in place:

- Domain purchased from any registrar (Namecheap, GoDaddy, Google Domains, etc.)
- Cloudflare account created (free tier is sufficient)
- Render.com application already deployed and running
- Access to your domain registrar's DNS settings (you control this)

---

## Step 1: Claim Your Domain in Cloudflare

### 1.1 Enter Cloudflare

1. Navigate to https://dash.cloudflare.com
2. Sign in with your credentials
3. Click "Add a Site" on the dashboard

### 1.2 Declare Your Domain

```
Domain: orin.work
```

1. Click "Add site"
2. Select the "Free" plan (everything you need)
3. Click "Continue"

### 1.3 Wait for DNS Scan

Cloudflare will scan your existing DNS records. This takes about 1 minute. Let it work.

---

## Step 2: Update Nameservers - Transfer Control

### 2.1 Get Your Cloudflare Nameservers

After adding your site, Cloudflare provides 2 nameservers:

```
Example:
nameserver 1: aron.ns.cloudflare.com
nameserver 2: daisy.ns.cloudflare.com
```

These are your new DNS authorities. Control flows through them now.

### 2.2 Update at Your Registrar

Where you bought the domain, you must change its nameservers to Cloudflare's.

**For Namecheap:**

1. Log in to Namecheap
2. Go to Domain List > Click "Manage" next to orin.work
3. Find the "Nameservers" section
4. Select "Custom DNS"
5. Enter the 2 Cloudflare nameservers
6. Click "Save"

**For GoDaddy:**

1. Log in to GoDaddy
2. Go to My Products > Domains
3. Click on orin.work
4. Scroll to "Nameservers" section
5. Click "Change"
6. Select "Enter my own nameservers"
7. Enter the 2 Cloudflare nameservers
8. Click "Save"

**For Google Domains:**

1. Log in to Google Domains
2. Click on orin.work
3. Go to DNS tab
4. Click on "Custom name servers"
5. Enter the 2 Cloudflare nameservers
6. Click "Save"

### 2.3 Wait for DNS Propagation

**Propagation Time:** 5 minutes to 48 hours (usually 1-2 hours)

Check Cloudflare dashboard. When it shows "Active", control has transferred.

---

## Step 3: Configure DNS Records - Draw the Traffic Lines

### 3.1 Navigate to DNS Settings

1. In Cloudflare dashboard, click on orin.work
2. Go to DNS > Records

### 3.2 Add DNS Records for Render

**Add A Record (Root Domain):**

```
Type: A
Name: @
IPv4 address: [Your Render IP from Render dashboard]
Proxy status: Proxied (Orange cloud ON)
TTL: Auto
```

**Add CNAME Record (www subdomain):**

```
Type: CNAME
Name: www
Target: orin.work
Proxy status: Proxied (Orange cloud ON)
TTL: Auto
```

**Alternative: CNAME Directly to Render:**

```
Type: CNAME
Name: @
Target: your-app-name.onrender.com
Proxy status: Proxied (Orange cloud ON)
TTL: Auto
```

### 3.3 Enable Orange Cloud (Proxy)

This is critical: The cloud icon must be ORANGE (Proxied).

- Orange = Traffic goes through Cloudflare (CDN, SSL, Security)
- Gray = Direct to origin (Cloudflare is bypassed)

If you see gray, click it to turn it orange.

---

## Step 4: SSL/TLS Configuration - Encrypt the Layer

### 4.1 Set Encryption Mode to Full (Strict)

1. In Cloudflare, go to SSL/TLS > Overview
2. Set encryption mode to "Full (Strict)"
   - This ensures end-to-end encryption
   - Requires valid SSL certificate on Render (provided automatically)

### 4.2 Enable Always Use HTTPS

1. Go to SSL/TLS > Edge Certificates
2. Find "Always Use HTTPS"
3. Toggle it ON
4. This automatically redirects http://orin.work to https://orin.work

### 4.3 Enable HSTS (Highly Recommended)

1. Scroll down to "HTTP Strict Transport Security (HSTS)"
2. Click "Enable HSTS"
3. Check "I understand"
4. Configure:
   - Max Age: 6 months (recommended)
   - Include subdomains: ON
   - No-Sniff Header: ON
5. Click "Save"

HSTS tells browsers: Never trust unencrypted connections to this domain.

---

## Step 5: Connect to Render - Link Application to Domain

### 5.1 Add Custom Domain in Render

1. Log in to Render.com
2. Go to your web service
3. Click "Settings" tab
4. Scroll to "Custom Domains" section
5. Click "Add Custom Domain"
6. Enter: orin.work
7. Click "Save"

### 5.2 Add www Subdomain

Repeat the process for www.orin.work

### 5.3 Verify DNS Configuration

Render will verify that your DNS points correctly.

- Green checkmark = Domain is connected and ready
- Pending = Wait for DNS propagation

---

## Verification: Confirm Everything Works

### Test HTTP to HTTPS Redirect

```
curl -I http://orin.work
# Should return: HTTP/1.1 301 Moved Permanently
# Location: https://orin.work/
```

### Test SSL Certificate

```
curl -I https://orin.work
# Should return: HTTP/2 200
```

### Browser Test

1. Open: http://orin.work > Should redirect to https://orin.work
2. Open: https://orin.work > Should load with padlock icon (secure)
3. Open: https://www.orin.work > Should work

### Check DNS Propagation Globally

Use https://whatsmydns.net

1. Enter: orin.work
2. Type: A or CNAME
3. Check if it resolves correctly across multiple servers worldwide

---

## Troubleshooting: When Layers Break

### Domain Not Loading

**Problem:** "This site can't be reached"

**Solutions:**

1. Check DNS Propagation
   - Use whatsmydns.net
   - Wait up to 48 hours for full propagation
2. Verify Nameservers Changed
   ```
   nslookup -type=NS orin.work
   ```
   Should show Cloudflare nameservers
3. Check Cloudflare Status
   - Go to Cloudflare dashboard
   - Domain should show "Active" status

### SSL/TLS Errors

**Problem:** "Your connection is not private" or "NET::ERR_CERT_AUTHORITY_INVALID"

**Solutions:**

1. Check SSL/TLS Mode
   - Go to Cloudflare > SSL/TLS
   - Must be set to "Full (Strict)"
2. Wait for Certificate Generation
   - Cloudflare Universal SSL takes ~15 minutes to activate
   - Check status in SSL/TLS > Edge Certificates
3. Verify Render SSL
   - Render automatically provides SSL
   - Check Settings > Custom Domains for SSL status

### Mixed Content Warnings

**Problem:** Some resources loading over HTTP

**Solution:**

- Ensure all assets (images, scripts, CSS) use HTTPS or relative URLs
- Update code to use https:// or //

### Infinite Redirect Loop

**Problem:** Page keeps redirecting endlessly

**Solutions:**

1. Check Render SSL Settings
   - Render > Settings > Custom Domains
   - Verify SSL is enabled
2. Review SSL/TLS Mode
   - If "Full (Strict)" causes issues, try "Full" instead
   - But Full (Strict) is preferred

---

## Advanced: Email Configuration

### MX Records (For Email Through orin.work)

**If using Cloudflare Email Routing:**

```
Type: MX
Name: @
Mail server: route1.mx.cloudflare.net (Priority: 5)
Mail server: route2.mx.cloudflare.net (Priority: 23)
Mail server: route3.mx.cloudflare.net (Priority: 67)
```

### SPF Record

```
Type: TXT
Name: @
Content: v=spf1 include:_spf.mx.cloudflare.com ~all
```

### DKIM Record

```
Type: TXT
Name: cf2024-1._domainkey
Content: [Provided by Cloudflare Email Routing]
```

### DMARC Record

```
Type: TXT
Name: _dmarc
Content: v=DMARC1; p=reject; rua=mailto:your-email@example.com
```

---

## Verification Checklist

- Domain added to Cloudflare
- Nameservers updated at registrar
- DNS records configured (A/CNAME)
- Orange cloud enabled (Proxied)
- SSL/TLS set to "Full (Strict)"
- "Always Use HTTPS" enabled
- HSTS configured
- Custom domain added in Render
- Domain verified and active
- HTTP to HTTPS redirect working
- SSL certificate valid
- Email records configured (if applicable)

---

## Success

Your domain **orin.work** is now:

- Connected to Cloudflare
- Pointing to Render deployment
- Secured with SSL/TLS encryption
- Protected by Cloudflare's CDN and security layer
- Optimized for global performance

**Cost:** $0 (Using Cloudflare Free Tier + Render Free Tier)

You own this layer. You control the flow. You understand how it works. That's what matters.

---

## References

- [Cloudflare DNS Documentation](https://developers.cloudflare.com/dns/)
- [Render Custom Domains Guide](https://render.com/docs/custom-domains)
- [SSL/TLS Best Practices](https://developers.cloudflare.com/ssl/origin-configuration/ssl-modes/)

**Last Updated:** November 11, 2025
**Status:** Active and Running at https://orin.work
