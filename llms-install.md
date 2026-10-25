# Install the 9bot remote MCP server

Use this file when an agent such as Cline installs 9bot from a marketplace or from this repository. The person using the agent is a 9bot customer. There is no anonymous access.

9bot is an independent company and is not affiliated with, endorsed by, or sponsored by Meta Platforms or WhatsApp. WhatsApp is a trademark of its owner. Do not describe 9bot as a Meta or WhatsApp partner, product, or official integration.

## Do not run a local server

This repository is documentation and client metadata. Do not clone it to build, npm install, dockerize, or start a local MCP process. Do not add a stdio command, `npx`, `uvx`, or another local wrapper.

The server manages regular WhatsApp groups, announcement groups, and channels. Do not invent tool names for those. After authorization, use `tools/list` and call only the tools returned there.

Configure the hosted endpoint only:

- Name: `9bot`
- URL: `https://mcp.9bot.com.br/mcp`
- Transport: Streamable HTTP
- Authentication: OAuth 2.1 (PKCE S256)
- Registry ID: `br.com.9bot/mcp`

Do not put an `Authorization` header, access token, refresh token, client secret, or API key in the MCP config. 9bot does not use an API key for this endpoint.

## What the user needs first

1. An active 9bot subscription. A 7-day free trial is available at https://9bot.com.br/en/start-now. Do not guess a price.
2. MCP enabled in the 9bot Dashboard at **Settings > MCP**.
3. An application set to read-only (`9bot.read_only`) or full access (`9bot.full_access`), limited to the groups the user wants this agent to touch. Tools for announcement groups and channels are part of the same server. Use only the tools the application is actually given.
4. A client that can open a browser so the user can approve OAuth 2.1 (PKCE S256).

Ask the user to do the dashboard steps if they have not already. Do not invent a tenant URL. The endpoint above is the universal one.

## Preferred setup: Cline Remote Servers

1. Open Cline's MCP Servers view.
2. Open the **Remote Servers** tab.
3. Add a server named `9bot`.
4. Set the server URL to `https://mcp.9bot.com.br/mcp`.
5. Choose **Streamable HTTP**. Do not choose legacy SSE. The published transport in `server.json` is `streamable-http`.
6. Save. Leave tool auto-approval empty.
7. When Cline starts OAuth, ask the user to finish sign-in in the browser. Wait for that. Do not ask them to paste a token into the chat.

The Cline CLI can add the same remote server without a bearer header:

```bash
cline mcp add 9bot https://mcp.9bot.com.br/mcp --transport http
```

Omit `--yes` if you want the user to confirm the wizard. Do not pass `--header "Authorization: ..."`.

## Manual Cline config

If you edit the MCP settings JSON instead, add this entry. Cline's docs put the IDE file behind **MCP Servers > Configure > Configure MCP Servers**. The CLI file is `~/.cline/data/settings/cline_mcp_settings.json` unless `CLINE_MCP_SETTINGS_PATH` is set.

Set `"type": "streamableHttp"`. Cline treats a missing type as legacy SSE.

```json
{
  "mcpServers": {
    "9bot": {
      "type": "streamableHttp",
      "url": "https://mcp.9bot.com.br/mcp",
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

Keep `autoApprove` empty. 9bot can also require its own two-step confirmation for sensitive or destructive operations. An empty client list does not replace that confirmation.

## OAuth 2.1 (PKCE S256)

Let the MCP client run this flow. The live metadata is the source of truth. Read it before hard-coding any path:

- Protected resource metadata: `https://mcp.9bot.com.br/.well-known/oauth-protected-resource/mcp`
- Authorization server metadata: `https://mcp.9bot.com.br/.well-known/oauth-authorization-server`
- Public discovery commands in this repo: `examples/discovery.sh`

An unauthenticated request to the MCP endpoint returns `401` with a `WWW-Authenticate` header that points at the protected resource metadata. That is the start of the flow, not a failed install.

Human-readable agent auth steps are published at https://9bot.com.br/auth.md. In short:

1. The client registers itself, or uses a client the user already created.
   - Preferred when the client supports it: dynamic client registration, or a client ID metadata document. Public clients use PKCE with no client secret (`token_endpoint_auth_method: none`).
   - Fallback: the user creates an application in **Dashboard > Settings > MCP** and copies the Client ID and Client Secret into the client's secure credential store. Never commit the secret, and never ask the user to paste it into the chat.
2. The client sends the user to the authorization endpoint from the metadata. The current endpoint is `https://mcp.9bot.com.br/oauth/authorize`. The request uses `response_type=code`, `code_challenge_method=S256`, a `code_challenge`, `state`, the `redirect_uri`, the `scope`, and `resource=https://mcp.9bot.com.br/mcp`.
3. The user signs in to 9bot and approves the requested access. Request only `9bot.read_only` unless the user wants state-changing operations, in which case the application needs `9bot.full_access`.
4. The client checks that the `iss` parameter on the authorization response is `https://mcp.9bot.com.br`.
5. The client exchanges the code at the token endpoint, with the PKCE code verifier and the same `resource`. 9bot issues an access token and a refresh token. The client stores both. Renewal uses `grant_type=refresh_token`.
6. Later MCP requests send `Authorization: Bearer` to `https://mcp.9bot.com.br/mcp`. A successful sign-in does not mean every tool, group, announcement group, or channel is available. Discover tools with `tools/list` and use the schemas that come back. See `examples/tools-list.http`. Do not guess tool names for channels or announcement groups.

If a previously working token returns `401`, drop it and start authorization again. `403` means the token is valid but the scope, group, tool rule, or account does not allow that call.

## Other clients

Use the same URL and the same OAuth 2.1 (PKCE S256) sign-in. Exact commands and JSON are in [README.md](README.md):

- Claude Code: `claude mcp add --transport http 9bot https://mcp.9bot.com.br/mcp`
- VS Code: `code --add-mcp '{"name":"9bot","type":"http","url":"https://mcp.9bot.com.br/mcp"}'`
- Cursor and other `mcpServers` configs: a remote entry with that URL
- Gemini CLI: `gemini extensions install https://github.com/9-bot/mcp`
- ChatGPT, Gemini Apps, Copilot Studio, and LM Studio: add the remote URL in that client's MCP or custom-app settings and complete OAuth. If the client cannot register itself, use the dashboard Client ID and Client Secret.

Do not claim a client works until its own docs say it supports remote MCP and OAuth. Plan limits on the client side are the client's, not 9bot's.

## Check that it worked

After the user finishes the browser approval, ask a read-only question, for example:

```text
Which of my groups are most active this week?
```

Use only tools returned for this application. If the list is empty, stop and check the application scope, the authorized groups, and the tool allow and deny lists. The same list is where you find tools for announcement groups and channels. Do not send a message, create a Workflow, change moderation, or schedule anything during a setup check unless the user explicitly asks for that action.

For a write the user did ask for, follow 9bot's preview. Sensitive or destructive operations can require a temporary, single-use confirmation submitted a second time. Report the tool result. Do not claim success when the call is waiting for confirmation or still running.

## Secrets

Never place access tokens, refresh tokens, authorization codes, client secrets, verification codes, or confirmation tokens in URLs, prompts, logs, screenshots, or source control. Do not share one account's credentials with another account.
