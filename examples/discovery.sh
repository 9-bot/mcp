#!/usr/bin/env sh
# Public, unauthenticated discovery endpoints
curl -s https://mcp.9bot.com.br/.well-known/oauth-protected-resource
curl -s https://mcp.9bot.com.br/.well-known/oauth-authorization-server
curl -s https://mcp.9bot.com.br/server.json
