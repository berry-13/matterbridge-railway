#!/bin/sh
set -e

# Substitute environment variables in the config template
envsubst < /etc/matterbridge/matterbridge.toml.template > /tmp/matterbridge.toml

# Run matterbridge with the processed config
exec /matterbridge -conf /tmp/matterbridge.toml
