# 9bot MCP

[![Smithery](https://smithery.ai/badge/ninebot/whatsapp)](https://smithery.ai/servers/ninebot/whatsapp)

Official Model Context Protocol (MCP) integration for **9bot**.

Connect AI assistants and agents to your WhatsApp groups, communities and channels through 9bot.

## MCP Endpoint

```text
https://mcp.9bot.com.br/mcp
```

**Transport:** Streamable HTTP
**Authentication:** OAuth 2.0
**Official MCP Registry ID:** `br.com.9bot/mcp`

## What you can do

The 9bot MCP gives compatible AI clients access to 9bot tools for WhatsApp community management, including:

* Manage WhatsApp groups, communities and channels
* Schedule and send messages
* Access group and community information
* Analyze activity and engagement
* View metrics and operational data
* Manage members and administrators
* Moderate communities
* Access scheduled messages and automations
* Perform supported 9bot actions directly from AI assistants

Available tools and permissions depend on the authenticated 9bot tenant.

## Connect

Use the following remote MCP endpoint in compatible clients:

```text
https://mcp.9bot.com.br/mcp
```

9bot uses OAuth 2.0 for authentication.

When connecting, users authenticate with the WhatsApp number associated with their 9bot account and confirm a verification code sent through WhatsApp.

9bot then securely identifies the corresponding tenant and authorizes access to its MCP tools.

No tenant URL, API key or MCP credential needs to be entered manually when using the universal MCP endpoint.

## Requirements

An active **9bot subscription** is required to access the MCP service.

New users can create an account and choose a plan at:

**https://9bot.com.br/en/start-now**

## How it works

```text
AI Client
   │
   ▼
mcp.9bot.com.br
   │
   ▼
9bot OAuth
   │
   ├── WhatsApp number
   └── Verification code
   │
   ▼
Tenant identification
   │
   ▼
Subscription & authorization
   │
   ▼
9bot MCP
   │
   ▼
WhatsApp groups, communities and channels
```

The universal MCP gateway handles authentication and tenant discovery automatically while keeping each 9bot tenant isolated.

## Compatible Clients

The 9bot MCP uses the open Model Context Protocol standard and is designed to work with clients that support remote MCP servers and OAuth authentication.

Compatibility depends on each client's current MCP implementation.

## MCP Registry

9bot is published in the official Model Context Protocol Registry as:

```text
br.com.9bot/mcp
```

The canonical remote server is:

```text
https://mcp.9bot.com.br/mcp
```

## Smithery

9bot is also available through Smithery:

**`ninebot/whatsapp`**

[![smithery badge](https://smithery.ai/badge/ninebot/whatsapp)](https://smithery.ai/servers/ninebot/whatsapp)

## Security

Authentication and authorization are handled by 9bot.

Never share:

* OAuth access tokens
* Refresh tokens
* WhatsApp verification codes
* MCP credentials
* Tenant credentials

Please do not disclose security vulnerabilities through public GitHub issues.

For security-related reports, contact 9bot through our official support channels.

## About 9bot

9bot is a platform for managing and automating WhatsApp groups, communities and channels.

It provides tools for scheduling, moderation, analytics, member management, automation and community operations.

**Website:** https://9bot.com.br/

**MCP:** https://mcp.9bot.com.br/

**Get started:** https://9bot.com.br/en/start-now

---

This repository contains the public documentation and metadata for the hosted 9bot MCP service.

The production MCP gateway and 9bot platform are operated as hosted services and are not distributed through this repository.
