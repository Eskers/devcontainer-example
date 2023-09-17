FROM  registry.access.redhat.com/ubi9/ubi-minimal

# Use build arg in devcontainer.json
ARG USERNAME

# The UBI minimal image uses microdonf
RUN microdnf update -y && \
    # Required for VSCode to set up devcontainer
    microdnf install -y git tar shadow-utils --nodocs --setopt install_weak_deps=0 && \
    # Install bash completions
    microdnf install -y bash-completion --setopt install_weak_deps=0 && \
    # Install development environment packages
    microdnf install -y python3.11 --setopt install_weak_deps=0 && \
    # Remove repo metadata to minimise image size
    microdnf clean all -y

# Add vscode user
RUN useradd -G wheel -m ${USERNAME}

# Copy bashrc
COPY ./config/bashrc /home/${USERNAME}/.bashrc
COPY ./config/git.sh /home/${USERNAME}/.bashrc.d/

WORKDIR /workspace
