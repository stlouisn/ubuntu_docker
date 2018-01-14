FROM ubuntu:rolling

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

#######################################################

    # Update apt-cache
    apt update && \

    # Update Ubuntu
    apt upgrade -y && \

    # Install tzdata
    apt install -y --no-install-recommends \
        tzdata && \

    # Install SSL
    apt install -y --no-install-recommends \
        ca-certificates \
        openssl && \

    # Install curl
    apt install -y --no-install-recommends \
        curl && \

    # Install gosu
    apt install -y --no-install-recommends \
        gosu && \

#######################################################

    #sed -i "s@:/usr/games@@" /etc/environment && \
    #sed -i "s@:/usr/local/games@@" /etc/environment && \
    #sed -i "s@alias l='ls -CF'@alias l='ls -la'@ /root/.bashrc && \

#######################################################

    # Clean apt-cache
    apt autoremove -y --purge && \
    apt autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*
