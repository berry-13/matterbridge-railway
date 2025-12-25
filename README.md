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
| `SLACK_BOT_TOKEN` | Slack Bot User OAuth Token (`xoxb-...`) |
| `SLACK_APP_TOKEN` | Slack App-Level Token (`xapp-...`) for Socket Mode |
| `SLACK_CHANNEL` | Slack channel name without `#` (e.g. `betterstack-status`) |
| `DISCORD_BOT_TOKEN` | Discord Bot Token with Message Content Intent enabled |
| `DISCORD_SERVER` | Discord server ID (enable Developer Mode → right-click server → Copy ID) |
| `DISCORD_CHANNEL` | Discord channel ID (right-click channel → Copy ID, e.g. `1234567890123456789`) |
| `DISCORD_PING` | (Optional) Role or user to ping: `<@&ROLE_ID>` for roles, `<@USER_ID>` for users |

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

- Uses [tippl's matterbridge fork](https://github.com/tippl/matterbridge) with Slack Socket Mode support
- Slack Events API (modern apps) - Classic Apps deprecated since June 2024
- Discord AutoWebhooks enabled for proper username/avatar display
- **Unidirectional**: Slack → Discord only

---

## 🔧 Setup Requirements

### Slack (Modern App with Socket Mode)
1. Create a new app at [api.slack.com/apps](https://api.slack.com/apps) → "Create New App" → "From scratch"
2. Go to **Socket Mode** and enable it - this generates your `xapp-...` token
3. Go to **OAuth & Permissions** and add these Bot Token Scopes:
   - `channels:history`, `channels:read`
   - `chat:write`, `chat:write.customize`
   - `groups:history`, `groups:read`
   - `im:history`, `im:read`
   - `mpim:history`, `mpim:read`
   - `users:read`, `users.profile:read`
4. Go to **Event Subscriptions**, enable events, and subscribe to:
   - `message.channels`, `message.groups`, `message.im`, `message.mpim`
5. Install app to workspace and copy **Bot User OAuth Token** (`xoxb-...`)
6. Invite the bot to your channel: `/invite @botname`

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
