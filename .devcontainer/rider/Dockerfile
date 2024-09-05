FROM mcr.microsoft.com/devcontainers/base:bookworm

# give rider user sudo access
RUN apt-get update \
&& apt-get install -y sudo \
&& sudo echo "rider ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/rider \
&& sudo chmod 0440 /etc/sudoers.d/rider \
&& sudo chmod -R +x **/src/*.sh \
&& sudo apt-get clean -y 

USER rider
