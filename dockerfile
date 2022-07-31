FROM ubuntu:latest

COPY rootfs /

RUN \

    # Non-interactive frontend
    export DEBIAN_FRONTEND=noninteractive && \

    # Update apt-cache
    apt-get update -qq && \

    # Upgrade all packages
    apt-get upgrade -yqq && \

    # Install apt-utils
    apt-get install -yqq --no-install-recommends \
        apt-utils && \

    # Install tzdata
    apt-get install -yqq --no-install-recommends \
        tzdata && \

    # Install SSL
    apt-get install -yqq --no-install-recommends \
        ca-certificates \
        openssl && \

    # Install curl
    apt-get install -yqq --no-install-recommends \
        curl && \

    # Install gosu
    apt-get install -yqq --no-install-recommends \
        gosu && \

    # Install shell tools
    apt-get install -yqq --no-install-recommends \
        bash-completion \
        nano \
        tree && \

    # Customize root profile
    sed -i "s@alias ll='ls@#alias ll='ls@" /root/.bashrc && \
    sed -i "s@alias la='ls@#alias la='ls@" /root/.bashrc && \
    sed -i "s@alias l='ls@#alias l='ls@" /root/.bashrc && \

    # Clean apt-cache
    apt-get autoremove -yqq --purge && \
    apt-get autoclean -yqq && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

CMD ["/bin/bash", "-l"]
