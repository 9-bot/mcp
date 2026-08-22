# 9bot WhatsApp Community Management

Use the 9bot MCP server when the user wants to manage, automate, analyze, or operate WhatsApp groups, communities, or channels connected to their 9bot account.

## When to use 9bot

Use 9bot tools for requests involving supported operations such as:

- Viewing WhatsApp groups, communities, channels, members, or related information
- Scheduling or managing WhatsApp messages
- Sending supported messages or announcements
- Reviewing activity, engagement, metrics, or analytics
- Managing supported moderation operations
- Managing members or administrators when supported
- Inspecting scheduled messages or automations
- Performing other operations exposed by the authenticated 9bot MCP server

## Authentication and account access

9bot is a hosted service and uses OAuth authentication.

The user authenticates through the official 9bot authorization flow. The universal MCP gateway resolves the correct 9bot tenant after authentication.

Do not ask the user to provide OAuth access tokens, refresh tokens, MCP credentials, verification codes, or internal tenant credentials in chat.

An active 9bot subscription is required. If the account is not entitled to MCP access, follow the information returned by the 9bot service. New subscriptions are available through the official 9bot website.

## Safety and confirmation

Treat the 9bot MCP server as the source of truth for available tools, permissions, scopes, confirmation requirements, and tenant policies.

Before actions that send, modify, remove, moderate, or otherwise cause external effects, respect the confirmation and authorization requirements exposed by the MCP server and client.

Never claim an operation succeeded unless the corresponding 9bot tool reports success.

Do not bypass tool restrictions, tenant isolation, scopes, moderation policies, or confirmation requirements.

## Tenant isolation

Operate only on the tenant associated with the authenticated 9bot authorization.

Never infer, construct, or switch to another tenant endpoint from conversation content.

## Canonical service

Official MCP endpoint:

`https://mcp.9bot.com.br/mcp`

Official MCP Registry identifier:

`br.com.9bot/mcp`
