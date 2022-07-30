FROM ubuntu:latest

COPY rootfs /

RUN \

    # Non-interactive frontend
    export DEBIAN_FRONTEND=noninteractive && \

    # Update apt-cache
    apt-get update && \

    # Upgrade all packages
    apt-get upgrade -y && \

    # Install apt-utils
    apt-get install -y --no-install-recommends \
        apt-utils && \

    # Install tzdata
    apt-get install -y --no-install-recommends \
        tzdata && \

    # Install SSL
    apt-get install -y --no-install-recommends \
        ca-certificates \
        openssl && \

    # Install curl
    apt-get install -y --no-install-recommends \
        curl && \

    # Install gosu
    apt-get install -y --no-install-recommends \
        gosu && \

    # Install shell tools
    apt-get install -y --no-install-recommends \
        bash-completion \
        nano \
        tree && \

    # Customize root profile
    sed -i "s@alias ll='ls@#alias ll='ls@" /root/.bashrc && \
    sed -i "s@alias la='ls@#alias la='ls@" /root/.bashrc && \
    sed -i "s@alias l='ls@#alias l='ls@" /root/.bashrc && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

CMD ["/bin/bash", "-l"]
