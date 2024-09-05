#!/bin/bash

sudo mkdir -p /workspaces/devcontainers-workshop \
&& sudo chown -R rider:rider /workspaces/devcontainers-workshop \
&& git config --global --add safe.directory /workspaces/devcontainers-workshop 

echo "Done bootstrapping devcontainer workspace"