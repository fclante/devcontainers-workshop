# Introduction To Devcontainers

- [Introduction To Devcontainers](#introduction-to-devcontainers)
  - [What is a Devcontainer?](#what-is-a-devcontainer)
  - [Why use Devcontainers?](#why-use-devcontainers)
  - [How to work with Devcontainers?](#how-to-work-with-devcontainers)
    - [How to create a Devcontainer?](#how-to-create-a-devcontainer)
    - [How to use a Devcontainer?](#how-to-use-a-devcontainer)
    - [How to customize a Devcontainer?](#how-to-customize-a-devcontainer)
  - [References](#references)

## What is a Devcontainer?

A Devcontainer is a containerized development environment that can be used to develop applications. It is a lightweight, portable, and reproducible environment that can be used to develop applications in a consistent manner. Devcontainers are typically used in conjunction with Visual Studio Code, but they can also be used with other development tools.

---

## Why use Devcontainers?

Devcontainers offer several benefits over traditional development environments:

- **Consistency**: Devcontainers provide a consistent development environment that can be used across different machines and operating systems. This helps to reduce the likelihood of bugs and issues that can arise from differences in development environments.

- **Portability**: Devcontainers are lightweight and portable, making it easy to share development environments with other developers. This can be useful for onboarding new team members or collaborating with other developers.

- **Reproducibility**: Devcontainers are reproducible, meaning that the development environment can be easily recreated from a configuration file. This makes it easy to set up a development environment on a new machine or recover from a corrupted environment.

- **Isolation**: Devcontainers run in isolated containers, which helps to prevent conflicts between different development environments. This can be useful when working on multiple projects that require different dependencies or configurations.

- **Security**: Devcontainers provide a secure development environment that is isolated from the host machine. This helps to prevent security vulnerabilities and protect sensitive data.

- **Scalability**: Devcontainers can be easily scaled to support different development environments, such as different programming languages or frameworks. This makes it easy to switch between different development environments without having to install additional dependencies.

- **Cost-effective**: Devcontainers are cost-effective, as they require minimal resources to run. This makes it easy to set up development environments on low-spec machines or in cloud environments.

Overall, Devcontainers offer a number of benefits that can help to improve the development process and make it easier to collaborate with other developers.

---

## How to work with Devcontainers?

The following sections provide an overview of how to work with Devcontainers, including how to create, use, and customize them.

---

### How to create a Devcontainer?

The single most important file in a Devcontainer is the `devcontainer.json` file. This file contains the configuration for the Devcontainer, including the base image, the extensions to install, and the settings to apply. Here is an  `devcontainer.json` file:

```json
// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/python
{
 "build": {
  "dockerfile": "Dockerfile",
  "args": {
   "ACTIONLINT_VERSION": "1.6.26"
  }
 },
 "features": {
  "ghcr.io/devcontainers/features/node:1": {
   "version": "20"
   }
  },
 "remoteUser": "vscode",
 "customizations": {
  "vscode": {
   "extensions": [
    "redhat.vscode-yaml",
    "rogalmic.bash-debug",
    "ms-python.python",
    "ms-python.isort",
    "ms-toolsai.jupyter",
    "ms-toolsai.vscode-jupyter-cell-tags",
    "ms-toolsai.jupyter-renderers",
    "ms-toolsai.vscode-jupyter-slideshow",
    "ms-python.vscode-pylance",
    "DotJoshJohnson.xml",
    "ms-azuretools.vscode-docker",
    "shakram02.bash-beautify",
    "mhutchie.git-graph",
    "GitHub.copilot",
    "GitHub.copilot-chat",
    "GitHub.heygithub"
   ]
  }
 },
 "workspaceFolder": "/workspaces/myapp",
 "workspaceMount": "source=${localWorkspaceFolder},target=/workspaces/myapp,type=bind,consistency=cached",
 "containerEnv": {
  "GHP_USER": "${localEnv:GHP_USER}",
  "GHP_TOKEN": "${localEnv:GHP_TOKEN}",
 },
 "mounts": [
  "source=${localWorkspaceFolder}/bash_config,target=/home/vscode,type=bind,consistency=cached"
 ],
 "postStartCommand": "git config --global --add safe.directory /workspaces/myapp"
}
```

> Note the `build.dockerfile` key in the `devcontainer.json` file. This key specifies the path to the Dockerfile that will be used to build the Devcontainer image. The Dockerfile contains the instructions for building the Devcontainer image, such as installing dependencies and setting up the development environment.

This is the Dockerfile that is used to build the Devcontainer image:

```dockerfile
FROM mcr.microsoft.com/devcontainers/python:0-3.10

ARG ACTIONLINT_VERSION=1.6.26

ENV ACTIONLINT_ARCHIVE=actionlint_${ACTIONLINT_VERSION}_linux_amd64.tar.gz
# give vscode user sudo access
RUN apt-get update \
&& apt-get install -y sudo wget unzip \
&& wget https://github.com/rhysd/actionlint/releases/download/v${ACTIONLINT_VERSION}/${ACTIONLINT_ARCHIVE} \
&& tar xvf ${ACTIONLINT_ARCHIVE} \
&& mv actionlint /usr/local/bin/ \
&& wget https://github.com/carvel-dev/ytt/releases/download/v0.45.0/ytt-linux-amd64 \
&& mv ytt-linux-amd64 /usr/local/bin/ytt \
&& chmod +x /usr/local/bin/ytt /usr/local/bin/actionlint \
&& echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vscode \
&& chmod 0440 /etc/sudoers.d/vscode \
&& apt-get clean -y \
&& echo "myapp" > /etc/hostname

USER vscode

RUN sudo python3 -m pip install --upgrade build twine poetry pyyaml yamale python-util requests \
&& sudo mkdir -p /workspaces/myapp \
&& sudo chown -R vscode:vscode /workspaces/myapp

```

---

### How to use a Devcontainer?

To use a Devcontainer, you need[^1] [^2] to have Visual Studio Code installed on your machine [^3]. You can then open a project folder in Visual Studio Code and click on the "Reopen in Container" button in the bottom right corner of the window. This will open the project folder in a Devcontainer, allowing you to develop the application in the containerized environment.

> You can download Visual Studio Code from the official website: [https://code.visualstudio.com/](https://code.visualstudio.com/)

---

### How to customize a Devcontainer?

It depends heavily on your needs, but you can customize a Devcontainer in several ways:

- **Base image**: You can customize the base image used for the Devcontainer by specifying a different image in the `devcontainer.json` file. This can be useful if you need to use a specific version of a programming language or framework.

- **Extensions**: You can customize the extensions installed in the Devcontainer by adding or removing extensions in the `devcontainer.json` file. This can be useful if you need to install additional tools or libraries for your development environment.

- **Settings**: You can customize the settings applied to the Devcontainer by adding settings in the `devcontainer.json` file. This can be useful if you need to configure the development environment to match your preferences. 

- **Environment variables**: You can customize the environment variables passed to the Devcontainer by adding environment variables in the `devcontainer.json` file. This can be useful if you need to pass sensitive information or configuration settings to the Devcontainer.

- **Mounts**: You can customize the mounts used in the Devcontainer by adding mounts in the `devcontainer.json` file. This can be useful if you need to mount additional directories or files in the Devcontainer.

Overall, there are many ways to customize a Devcontainer to meet your specific needs. You can experiment with different configurations to find the setup that works best for you.

---

## References

- [Developing inside a Container - Visual Studio Code](https://code.visualstudio.com/docs/remote/containers)
- [Devcontainers - GitHub](https://github.com/devcontainers)
- [Jetbrains Gateway - Jetbrains](https://www.jetbrains.com/help/idea)
- [Devcontainers Reference Docs](https://containers.dev)

[^1]: IntelliJ Idea also has a plugin for working with Devcontainers. You can find more information about the plugin in the official documentation: [https://plugins.jetbrains.com/plugin/14890-devcontainers](https://plugins.jetbrains.com/plugin/14890-devcontainers)

[^2]: For Rider, use the Jetbrains Gateway is a new feature that allows you to connect to a remote development environment from your local machine. You can find more information about Jetbrains Gateway in the official documentation: [https://www.jetbrains.com/help/idea/remote-development.html](https://www.jetbrains.com/help/idea/remote-development.html)

[^3]: There's also a command-line interface for working with Devcontainers, which can be installed using the `vscode-dev-containers` extension. You can find more information about the command-line interface in the official documentation: [https://code.visualstudio.com/docs/remote/containers-cli](https://code.visualstudio.com/docs/remote/containers-cli)
