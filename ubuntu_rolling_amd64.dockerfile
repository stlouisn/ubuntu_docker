FROM amd64/ubuntu:rolling
## FROM amd64/ubuntu:latest

COPY rootfs /

RUN \
    #
    export DEBIAN_FRONTEND=noninteractive && \
    #
    # Update apt-cache
    apt-get update && \
    #
    # Upgrade all packages
    apt-get upgrade -y && \
    #
    # Install apt-utils
    apt-get install -y --no-install-recommends \
        apt-utils && \
    #
    # Install tzdata
    apt-get install -y --no-install-recommends \
        tzdata && \
    #
    # Install password generator
    apt-get install -y --no-install-recommends \
        pwgen && \
    #
    # Install SSL
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        openssl && \
    #
    # Install curl
    apt-get install -y --no-install-recommends \
        curl && \
    #
    # Install wget
    apt-get install -y --no-install-recommends \
        wget && \
    #
    # Install gosu
    apt-get install -y --no-install-recommends \
        gosu && \
    #
    # Install shell tools
    apt install -y --no-install-recommends \
        bash-completion \
        nano \
        tree && \
    #
    # Customize system profile
    sed -i "s@:/usr/games@@" /etc/environment && \
    sed -i "s@:/usr/local/games@@" /etc/environment && \
    #
    # Customize root profile
    sed -i "s@alias ll='ls@#alias ll='ls@" /root/.bashrc && \
    sed -i "s@alias la='ls@#alias la='ls@" /root/.bashrc && \
    sed -i "s@alias l='ls@#alias l='ls@" /root/.bashrc && \
    #
    # Remove unnecessary directories
    rm -rf \
        /opt \
        /usr/games \
        /usr/local/games \
        /srv \
        /var/log/* \
        /var/opt && \
    #
    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \
    #
    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*
        
CMD ["/bin/bash", "-l"]
