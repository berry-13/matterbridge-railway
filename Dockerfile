# Build from tippl's fork which has Slack Events API / Socket Mode support
# (Required since Classic Slack Apps were deprecated in June 2024)
FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git ca-certificates

WORKDIR /build
RUN git clone https://github.com/tippl/matterbridge.git . && \
    go build -o matterbridge

# Runtime image
FROM alpine:3.20

RUN apk add --no-cache ca-certificates gettext

COPY --from=builder /build/matterbridge /bin/matterbridge

# Copy config template and entrypoint script
COPY matterbridge.toml /etc/matterbridge/matterbridge.toml.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Health check for container orchestration
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD pgrep matterbridge || exit 1

# Use entrypoint to substitute env vars at runtime
ENTRYPOINT ["/entrypoint.sh"]
