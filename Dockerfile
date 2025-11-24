FROM 42wim/matterbridge:stable

# Copy config into the container
COPY matterbridge.toml /etc/matterbridge/matterbridge.toml

# Default CMD runs Matterbridge with the config
CMD ["/matterbridge", "-conf", "/etc/matterbridge/matterbridge.toml"]
