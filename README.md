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
| `SLACK_BOT_TOKEN` | Slack Bot User OAuth Token (xoxb-...) |
| `SLACK_CHANNEL` | Slack channel to read from (e.g. `#incidents`) |
| `DISCORD_WEBHOOK_URL` | Discord webhook URL |
| `DISCORD_CHANNEL` | Arbitrary label for logs (e.g. `incidents`) |

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

Slack → Matterbridge → Discord
(Using official Slack API and Discord Webhooks, no deprecated features.)

This is the most stable, future-proof method for routing Better Stack alerts from Slack into Discord.

**Note:** This configuration is **unidirectional** (Slack to Discord only). Discord webhooks are write-only and cannot receive messages. For bidirectional bridging, you would need to configure a Discord bot token instead of a webhook.

---

## 🔒 Security Notes

- All secrets should be stored using Railway **Variables**
- The `matterbridge.toml` file uses `${VAR}` placeholders
- No tokens are stored in the repo

---

## 📜 License

MIT License. See `LICENSE` for details.
