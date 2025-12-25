# Matterbridge Railway Deployment

A minimal repository for deploying **Matterbridge** to **Railway**, enabling stable Slack → Discord forwarding (or any other chat platforms supported by Matterbridge).

This repo:
- Uses the official Matterbridge image
- Injects a clean `matterbridge.toml`
- Supports Railway environment variables
- Requires no volumes or bind mounts
- Deploys instantly through Railway’s Docker builder

---

## 🚀 Deployment (Railway)

1. Click **New Project → Deploy from GitHub**  
2. Select this repository  
3. Railway will auto-detect the Dockerfile and build it  
4. Add the following required environment variables:

| Variable | Description |
|---------|-------------|
| `SLACK_BOT_TOKEN` | Slack Bot User OAuth Token (`xoxb-...`) from a [Classic App](https://api.slack.com/apps?new_classic_app=1) |
| `SLACK_CHANNEL` | Slack channel name without `#` (e.g. `betterstack-status`) |
| `DISCORD_BOT_TOKEN` | Discord Bot Token with Message Content Intent enabled |
| `DISCORD_SERVER` | Discord server name or ID |
| `DISCORD_CHANNEL` | Discord channel name (e.g. `incidents`) |

5. Deploy  
6. Done — Matterbridge will begin bridging messages automatically.

---

## 📁 File Structure

```
matterbridge-railway/
├── .github/
│   └── workflows/
│       └── docker-publish.yml
├── .dockerignore
├── .gitignore
├── Dockerfile
├── entrypoint.sh
├── matterbridge.toml
├── LICENSE
└── README.md
```

---

## 🧩 How it Works

```
Slack Channel → Matterbridge → Discord Channel
```

Messages posted in your Slack channel are automatically forwarded to Discord using Matterbridge.

- Uses official Slack and Discord Bot APIs
- AutoWebhooks enabled for proper username/avatar display
- **Unidirectional**: Slack → Discord only (Discord messages are not sent back to Slack)

---

## 🔧 Setup Requirements

### Slack (Classic App)
1. Create a [Slack App (Classic)](https://api.slack.com/apps?new_classic_app=1) - **must be Classic, not new**
2. Add a Legacy Bot User under "App Home"
3. Add OAuth scopes: `channels:write`, `chat:write:bot`, `chat:write:user`, `users.profile:read`
4. Install to workspace and copy the **Bot User OAuth Token** (`xoxb-...`)
5. Invite the bot to your channel: `/invite @botname`

### Discord
1. Create an app at [Discord Developer Portal](https://discord.com/developers/applications)
2. Add a Bot and copy the token
3. Enable **Message Content Intent** and **Server Members Intent** under Bot settings
4. Invite bot to server with Manage Webhooks permission:
   `https://discord.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&scope=bot&permissions=536870912`

---

## 🔒 Security Notes

- All secrets should be stored using Railway **Variables**
- The `matterbridge.toml` file uses `${VAR}` placeholders
- No tokens are stored in the repo

---

## 📜 License

MIT License. See `LICENSE` for details.
