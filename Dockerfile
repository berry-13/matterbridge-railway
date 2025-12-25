# Pin to specific version for reproducibility (update as needed)
FROM 42wim/matterbridge:1.26.0

# Install envsubst for environment variable substitution
USER root
RUN apk add --no-cache gettext

# Copy config template and entrypoint script
COPY matterbridge.toml /etc/matterbridge/matterbridge.toml.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Health check for container orchestration
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD pgrep matterbridge || exit 1

# Use entrypoint to substitute env vars at runtime
ENTRYPOINT ["/entrypoint.sh"]
