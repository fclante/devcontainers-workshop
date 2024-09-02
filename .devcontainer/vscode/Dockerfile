FROM mcr.microsoft.com/devcontainers/base:bookworm

# give vscode user sudo access
RUN apt-get update \
&& apt-get install -y sudo \
&& sudo echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode \
&& sudo chmod 0440 /etc/sudoers.d/vscode \
&& sudo chmod +x src/bootstrap_vscode.sh \
&& sudo apt-get clean -y 

USER vscode
