FROM ubuntu:rolling

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

    # Update and upgrade
    apt-get update && apt-get upgrade -y && \

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
    apt install -y --no-install-recommends \
        nano \
        tree && \

    # Customize system profile
    sed -i "s@:/usr/games@@" /etc/environment && \
    sed -i "s@:/usr/local/games@@" /etc/environment && \

    # Customize root profile
    sed -i "s@alias l='ls -CF'@alias l='ls -la'@" /root/.bashrc && \

    # Remove unnecessary files
    rm -rf \
        /opt \
        /usr/games \
        /srv \
        /var/opt && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get clean -y && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*
