# Webhooks: Understanding Meta Integration Through n8n

## What This Is

This isn't a "quick start guide" wrapped in corporate speak. This is a documentation of how webhooks work, why Meta needs them to verify you're real, and how to make your n8n instance talk to Meta's systems without compromise. It's about understanding another layer.

## The Problem: When Meta Doesn't Trust You

Meta returns an error: *"The callback URL or verify token couldn't be validated."*

What they're really saying: "We sent you a request. You didn't respond correctly. We don't know if you're real."

This isn't a bug. This is a security layer. Meta wants to verify that the webhook URL you registered is actually under your control. They're not wrong to ask.

## How Verification Works: The Handshake

Meta's verification is brutally simple:

1. **Meta sends a GET request** to your webhook URL with two parameters:
   - `hub.challenge` - a random string
   - `hub.verify_token` - the token you told Meta to send

2. **You must respond immediately** with:
   - HTTP status: 200
   - Response body: Echo back the exact `hub.challenge` value
   - Header: `Content-Type: text/plain`

3. **Meta validates the response**. If the challenge matches what they sent, you passed. You're real.

That's it. That's the entire verification protocol.

## Why This Matters

You need to understand this because n8n, by default, doesn't handle verification correctly. The webhook node works fine for regular requests, but verification is different. It's a specific protocol. If you don't handle it, Meta won't connect. Your workflows won't run.

## The Solution: Respond to Webhook Node

N8n has a node specifically for this: **Respond to Webhook**. This node gives you control over the exact HTTP response your webhook sends.

### Setup

**1. Webhook Node Configuration:**
- HTTP Methods: GET + POST (Meta uses both)
- Respond: Set to "Using Respond to Webhook Node" (critical)
- Path: `/webhook/YOUR_UNIQUE_ID`

**2. Respond to Webhook Node Configuration:**
- Response Body (Expression mode): `{{ $('Webhook').item.json.query['hub.challenge'] }}`
- Response Headers: Add `Content-Type: text/plain`
- Response Code: 200 (default)

**3. Workflow State:**
- Must be **Active** - not in test mode
- Must be **Saved** - changes must persist

Why? Because test mode is manual. Your workflow needs to be always-listening. Production means 24/7.

## Your Webhook URL

```
https://n8n.orin.work/webhook/3e369b98-dc87-46f7-9602-d45d5859827c
```

This URL is:
- Public (HTTPS)
- Reachable from Meta's servers
- Tied to your specific workflow
- Not changing unless you recreate the webhook

## Putting It in Meta's Console

1. Go to your Meta App Dashboard
2. Find Webhooks section
3. Enter your callback URL
4. Enter your Verify Token (make this secure, make it yours)
5. Click "Verify and Save"

Meta sends the verification challenge. Your n8n responds with the challenge. Meta sees the match. Boom. Connected.

## What's Next

Once verified, Meta will send actual events to your webhook. Each event is a POST request with the data you need.

But understanding verification first? That's understanding another layer. That's control.

## The Philosophy

Most people just copy-paste solutions without understanding why they work. They hit errors and panic. You're reading this because you want to understand the layer.

Every layer you understand is a layer you control.

The webhook verification protocol is simple, elegant, and deliberate. Meta isn't trying to confuse you. They're trying to prevent fake registrations. Once you understand it, it's not a problem anymore. It's just a protocol.

---

**Status**: Production ready. Your webhook is live and listening.
**Date**: November 16, 2025
**Philosophy**: Layers. Understanding. Control.
