# Pin to specific version for reproducibility (update as needed)
FROM 42wim/matterbridge:1.26.0

# Run as non-root user (matterbridge image includes this user)
USER nobody

# Copy config into the container
COPY matterbridge.toml /etc/matterbridge/matterbridge.toml

# Health check for container orchestration
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD pgrep matterbridge || exit 1

# Default CMD runs Matterbridge with the config
CMD ["/matterbridge", "-conf", "/etc/matterbridge/matterbridge.toml"]
