FROM ubuntu:latest AS ubuntu-base

ARG TARGETARCH
ARG APP_VERSION

RUN \

    # Non-interactive frontend
    export DEBIAN_FRONTEND=noninteractive && \

    # Update apt-cache
    apt-get update && \

    # Upgrade all packages
    apt-get upgrade -y && \

    # Install apt-utils [ 750 kb ]
    apt-get install -y --no-install-recommends \
        apt-utils && \

    # Install tzdata [ 3925 kb ]
    apt-get install -y --no-install-recommends \
        tzdata && \

    # Install SSL [ 2413 kb ]
    apt-get install -y --no-install-recommends \
        ca-certificates \
        openssl && \

    # Install curl [ 3642 kb ]
    # apt-get install -y --no-install-recommends \
    #     curl && \

    # Install wget [ 1072 kb ]
    # apt-get install -y --no-install-recommends \
    #     wget && \

    # Install gosu [ 2212 kb ]
    apt-get install -y --no-install-recommends \
        gosu && \

    # Install nano [ 277 kb ]
    apt-get install -y --no-install-recommends \
        nano && \

    # Install tree [ 108 kb ]
    apt-get install -y --no-install-recommends \
        tree && \

    # Customize root profile
    sed -i "s@alias ll='ls@#alias ll='ls@" /root/.bashrc && \
    sed -i "s@alias la='ls@#alias la='ls@" /root/.bashrc && \
    sed -i "s@alias l='ls@#alias l='ls@" /root/.bashrc && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Remove unnecessary and temporary directories
    rm -rf \
        /etc/cron.d \
        /etc/cron.daily \
        /opt \
        /root/.bash_history \
        /root/.cache \
        /root/.wget-hsts \
        /srv \
        /tmp/* \
        /usr/games \
        /usr/local/games \
        /usr/local/man \
        /usr/local/share/man \
        /usr/share/doc \
        /usr/share/doc-base \
        /usr/share/info \
        /usr/share/man \
        /var/cache/* \
        /var/lib/apt \
        /var/log/* \
        /var/opt && \

COPY rootfs /

FROM scratch

COPY --from=ubuntu-base / /

CMD ["/bin/bash", "-l"]
