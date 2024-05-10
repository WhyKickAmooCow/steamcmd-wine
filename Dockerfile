FROM docker.io/steamcmd/steamcmd:ubuntu-24

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386

RUN apt update \
    && apt install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    cabextract \
    git \
    gnupg \
    gosu \
    gpg-agent \
    locales \
    p7zip \
    pulseaudio \
    pulseaudio-utils \
    sudo \
    tzdata \
    unzip \
    xz-utils \
    wget \
    curl \
    winbind \
    xwayland \
    weston \
    xauth \
    zenity \
    jq \
    gettext \
    && rm -rf /var/lib/apt/lists/*

RUN apt update \
    && apt install -y --install-recommends wine \
    && ln -s /usr/bin/wine /usr/bin/wine64 \
    && rm -rf /var/lib/apt/lists/*

ADD --chmod=777 https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks /usr/bin/winetricks

ENTRYPOINT [ "steamcmd" ]