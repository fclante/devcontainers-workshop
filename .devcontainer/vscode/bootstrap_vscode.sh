#!/bin/bash

python3 -m pip install --upgrade build \

&& python3 -m pip install twine \
&& python3 -m pip install poetry \
&& sudo mkdir -p /workspaces/devcontainers-workshop \
&& sudo chown -R vscode:vscode /workspaces/devcontainers-workshop \
&& git config --global --add safe.directory /workspaces/devcontainers-workshop 

echo "Done bootstrapping devcontainer workspace"