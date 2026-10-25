<p align="center">
  <img src="assets/logo.png" alt="9bot logo" width="96">
</p>

<h1 align="center">9bot MCP</h1>

<p align="center">The MCP is 9bot's app inside your AI agent.</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue" alt="License: MIT"></a>
  <a href="https://registry.modelcontextprotocol.io/?q=br.com.9bot%2Fmcp"><img src="https://img.shields.io/badge/MCP%20Registry-br.com.9bot%2Fmcp-blue" alt="MCP Registry: br.com.9bot/mcp"></a>
</p>

Install it in Claude, ChatGPT, Gemini, Copilot, Cursor, VS Code, or LM Studio, and operate the WhatsApp groups, announcement groups, and channels connected to your 9bot account by talking to the AI.

9bot is a paid product for managing WhatsApp groups, announcement groups, and channels. This repository is the public documentation and install metadata for the hosted MCP server. The server itself is not distributed here.

> 9bot is an independent company and is not affiliated with, endorsed by, or sponsored by Meta Platforms or WhatsApp. WhatsApp is a trademark of its owner.

**Endpoint:** `https://mcp.9bot.com.br/mcp`  
**Transport:** Streamable HTTP  
**Authentication:** OAuth 2.1 (PKCE S256)  
**Registry ID:** `br.com.9bot/mcp`

## What you can do

After you sign in, the agent can use the 9bot tools your application is allowed to call. That includes regular groups, announcement groups, and channels. Availability depends on the scopes, groups, and tool rules for that application.

- Look up groups, announcement groups, channels, members, administrators, settings, and community information.
- Generate reports on activity, engagement, and behavior.
- Turn a request into a Workflow inside 9bot.
- Send messages through authorized groups, announcement groups, and channels.
- Schedule one-time or recurring communications.
- Query and operate existing automations and commands.
- Work with reports, strikes, penalties, allowlists, and other moderation features.
- Trigger integrations that the application is allowed to use.

These prompts are starting points from the [9bot MCP guide](https://9bot.com.br/en/mcp/). Change the group, time, and content to match your account.

- Which of my groups are most active this week?
- List my announcement groups and channels.
- List this group's administrators.
- Which groups grew the most over the last 30 days?
- List the most active members.
- Create a weekly engagement report.
- Generate a summary of this community's activity.
- Show active Workflows.
- Create a Workflow that sends a message every Friday at 6:00 PM.
- Every Monday at 9:00 AM, generate an engagement report and send it to the administrator.
- Create an RSS automation for this group.

## Install

There is nothing to download. Add the remote endpoint, then sign in with OAuth 2.1 (PKCE S256) the first time you use it.

If an agent is installing this for you, point it at [llms-install.md](llms-install.md).

### Before you connect

1. Use an active 9bot subscription. New accounts can start a 7-day free trial on the [plans page](https://9bot.com.br/en/start-now).
2. In the 9bot Dashboard, open **Settings > MCP** and enable MCP.
3. Create an application and choose **read-only** or **full access**. Limit it to the groups it should see.
4. Clients that complete OAuth 2.1 (PKCE S256) themselves, including dynamic client registration, do not need a tenant URL or API key in the config. If a client asks for its own OAuth client, copy the **Client ID**, **Client Secret**, and **MCP endpoint** from that application and store the secret in the client's credential manager.

The scopes are `9bot.read_only` and `9bot.full_access`.

Compatibility depends on the client's current support for remote MCP and OAuth 2.1 (PKCE S256). The guides below are the ones linked from the 9bot MCP page, plus the install commands already published in this repository.

<details>
<summary><strong>Claude</strong></summary>

**Claude, Claude Desktop, and Cowork**

Add a custom connector with this remote URL:

```text
https://mcp.9bot.com.br/mcp
```

Choose OAuth when Claude asks how to sign in, then approve access in the browser. Team and Enterprise owners add the connector for the organization first. Anthropic's steps are in [Get started with custom connectors using remote MCP](https://support.claude.com/en/articles/11175166-get-started-with-custom-connectors-using-remote-mcp).

**Claude Code**

```bash
claude mcp add --transport http 9bot https://mcp.9bot.com.br/mcp
```

</details>

<details>
<summary><strong>ChatGPT</strong></summary>

ChatGPT connects to the same remote URL:

```text
https://mcp.9bot.com.br/mcp
```

In the current ChatGPT plugins experience, open **Plugins**, choose **Add custom MCP server**, enter the URL, and configure OAuth. Complete the authorization prompt when it appears.

OpenAI's guide, [Connecting custom MCP servers in ChatGPT](https://help.openai.com/en/articles/12584461-developer-mode-and-mcp-apps-in-chatgpt), is the source for the current screens. That guide says full MCP connections are for Business and Enterprise/Edu workspaces, and that Pro users can connect custom MCP servers with read and fetch permissions. Workspace admins control who can create and publish the connection.

</details>

<details>
<summary><strong>Gemini</strong></summary>

**Gemini Apps**

In the Gemini web app, open **Settings > Connected Apps**, add a custom app, and enter:

```text
https://mcp.9bot.com.br/mcp
```

If the client does not use dynamic client registration, open the advanced credential fields and use the Client ID and Client Secret from your 9bot application. Google's requirements and steps are in [Connect and manage custom apps for Gemini Apps](https://support.google.com/gemini/answer/17209137?hl=en). That guide currently limits custom apps to English, personal Google accounts, users 18 or over in the US, and accounts with Keep Activity on.

**Gemini CLI**

This repository is a Gemini CLI extension:

```bash
gemini extensions install https://github.com/9-bot/mcp
```

The extension manifest is [`gemini-extension.json`](gemini-extension.json).

</details>

<details>
<summary><strong>Copilot</strong></summary>

**Microsoft Copilot Studio**

Add an existing MCP server in the agent's **Tools** page. Use the server URL `https://mcp.9bot.com.br/mcp` and OAuth. When the wizard offers dynamic discovery, that is the option that matches 9bot's published authorization-server metadata and dynamic client registration. Microsoft's wizard is documented in [Connect your agent to an existing MCP server](https://learn.microsoft.com/en-us/microsoft-copilot-studio/mcp-add-existing-server-to-agent).

If the wizard asks for a manual OAuth client, use the Client ID and Client Secret from **Dashboard > Settings > MCP**. The scope is `9bot.read_only` or `9bot.full_access`.

**GitHub Copilot and VS Code agent plugins**

[`plugin.json`](plugin.json) and [`mcp.json`](mcp.json) are the Agent Plugins manifests for GitHub Copilot, VS Code agent plugins, and Kiro. The server entry is the remote URL above.

</details>

<details>
<summary><strong>Cursor</strong></summary>

Add this to Cursor's MCP config:

```json
{
  "mcpServers": {
    "9bot": {
      "url": "https://mcp.9bot.com.br/mcp"
    }
  }
}
```

The Cursor plugin files in this repository are [`.cursor-plugin/plugin.json`](.cursor-plugin/plugin.json) and [`.mcp.json`](.mcp.json). The project config includes `"type": "http"`:

```json
{
  "mcpServers": {
    "9bot": {
      "type": "http",
      "url": "https://mcp.9bot.com.br/mcp"
    }
  }
}
```

</details>

<details>
<summary><strong>VS Code</strong></summary>

```bash
code --add-mcp '{"name":"9bot","type":"http","url":"https://mcp.9bot.com.br/mcp"}'
```

</details>

<details>
<summary><strong>LM Studio</strong></summary>

Add a remote MCP integration with this URL and sign in through the browser when LM Studio opens the 9bot authorization page:

```text
https://mcp.9bot.com.br/mcp
```

LM Studio documents remote OAuth MCP in [MCP Integrations](https://lmstudio.ai/docs/integrations/mcp-remote). If it asks you to bring your own OAuth client, add the Client ID and Client Secret from your 9bot application and keep the secret out of git. LM Studio's documented shape for that case is:

```json
{
  "mcpServers": {
    "9bot": {
      "url": "https://mcp.9bot.com.br/mcp",
      "auth": {
        "CLIENT_ID": "YOUR_CLIENT_ID",
        "CLIENT_SECRET": "YOUR_CLIENT_SECRET"
      }
    }
  }
}
```

</details>

### Also listed

9bot is also listed on Smithery as [`ninebot/whatsapp`](https://smithery.ai/servers/ninebot/whatsapp). The install paths above talk to `https://mcp.9bot.com.br/mcp` directly.

### Plugin manifests

| Client | Files |
| --- | --- |
| GitHub Copilot, VS Code agent plugins, Kiro | [`plugin.json`](plugin.json), [`mcp.json`](mcp.json) |
| Cursor | [`.cursor-plugin/plugin.json`](.cursor-plugin/plugin.json), [`.mcp.json`](.mcp.json) |
| Claude Code | [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json) |
| Gemini CLI | [`gemini-extension.json`](gemini-extension.json) |
| MCP Registry | [`server.json`](server.json) (`br.com.9bot/mcp`) |

## Security and control

You decide what the agent can see and change. The controls below are the ones described on the [9bot MCP page](https://9bot.com.br/en/mcp/) and in this repository.

**OAuth 2.1 (PKCE S256).** The public endpoint requires OAuth 2.1 (PKCE S256). Dynamic client registration is supported. The client keeps access tokens and refresh tokens in its own credential store. Do not paste them into a chat, a config file that you commit, or a GitHub issue.

**Scopes, including read-only and full access.** Each application is created as read-only or full access. The scope values are `9bot.read_only` and `9bot.full_access`. Scope-based permissions limit which actions that application can perform. Use read-only when the agent only needs to look things up. Use full access when it needs to make changes. Either mode is still limited by the groups, tool rules, confirmation, and sensitive-data policy on that application.

**Groups.** Choose which groups each application can access. 9bot applies that selection when it discovers and runs tools. The server also has tools for announcement groups and channels. Which of those tools an application can call still depends on its scopes and rules.

**Tool allow and deny lists.** Each application can allow or block specific tools.

**Sensitive data.** Sensitive data can be set to blocked, masked, or full access, according to the application's policy.

**Two-step confirmation for writes.** 9bot can require two-step confirmation for sensitive or destructive operations. The preview creates a temporary, single-use confirmation that has to be submitted again before the action runs.

1. The agent receives the request.
2. 9bot shows the expected effect.
3. You confirm it.
4. The validated action runs.
5. The result is recorded.

**Audit log.** MCP changes are recorded for administrative review.

Do not share OAuth access tokens, refresh tokens, verification codes, client secrets, or tenant credentials.

Report security issues to [contato@9bot.com.br](mailto:contato@9bot.com.br), not through public GitHub issues. See [SECURITY.md](SECURITY.md).

## Toolsets

Published toolsets, as listed on the [9bot MCP page](https://9bot.com.br/en/mcp/). A given application only receives the tools its scopes, groups, and rules allow. Announcement groups and channels are part of what the server can manage. The table does not add a separate count for them, because those counts are not published as their own rows.

| Toolset | Tools | Purpose |
| --- | ---: | --- |
| Groups | 29 | Groups, members, and settings |
| Reports | 17 | Reports and analytics |
| Workflows | 40 | Authoring, deployment, and execution |
| Messages | 15 | Messages, summaries, and broadcasts |
| Schedules | 13 | Schedule management |
| Automations | 62 | Automations and commands |
| Moderation | 16 | Moderation |
| Integrations | 27 | Integrations |
| Community | 17 | Subdomains and hosted pages |
| Jobs | 4 | Job queries and control |

When no extra selector is provided, 9bot publishes these domains by default: `groups`, `reports`, and `workflows`.

## Pricing

MCP access is included in the 9bot plan. There is a 7-day free trial. Current prices are on the [plans page](https://9bot.com.br/en/start-now). This page does not list prices because they can change.

## Documentation and support

- MCP guide: https://9bot.com.br/en/mcp/
- Product docs: https://9bot.com.br/en/9bot-docs/
- Privacy policy: https://9bot.com.br/en/privacy-policy/
- Terms of use: https://9bot.com.br/en/terms-of-use/
- Trademark policy: [TRADEMARKS.md](TRADEMARKS.md)
- Support: [contato@9bot.com.br](mailto:contato@9bot.com.br)
- Website: https://9bot.com.br/

The production gateway at `https://mcp.9bot.com.br/mcp` is a hosted service. This repository publishes the registry manifest, client manifests, and these docs.
