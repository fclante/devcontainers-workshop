FROM mcr.microsoft.com/devcontainers/base:bookworm

COPY bootstrap_vscode.sh .
# give vscode user sudo access
RUN apt-get update \
&& apt-get install -y sudo \
&& sudo echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode \
&& sudo chmod 0440 /etc/sudoers.d/vscode \
&& sudo chmod +x bootstrap_vscode.sh \
&& sudo apt-get clean -y 

USER vscode

ENTRYPOINT [ "/bin/bash", "bootstrap_vscode.sh" ]
CMD ["/bin/bash"]

