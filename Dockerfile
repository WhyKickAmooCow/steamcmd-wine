FROM steamcmd/steamcmd:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386

RUN apt update
RUN apt install -y --no-install-recommends \
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
    wget \
    curl \
    winbind \
    xvfb \
    xauth \
    zenity \
    jq \
    gettext

ARG WINE_BRANCH="stable"
RUN curl https://dl.winehq.org/wine-builds/winehq.key | apt-key add - \
    && echo "deb https://dl.winehq.org/wine-builds/ubuntu/ $(grep VERSION_CODENAME= /etc/os-release | cut -d= -f2) main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --install-recommends winehq-${WINE_BRANCH}

RUN rm -rf /var/lib/apt/lists/*

ADD --chmod=777 https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks /usr/bin/winetricks

ENTRYPOINT [ "steamcmd" ]