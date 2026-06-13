FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

RUN apt-get update && apt-get install -y \
    xvfb \
    libx11-6 \
    libgl1-mesa-dri \
    libgl1 \
    libglu1-mesa \
    x11vnc \
    websockify \
    wget \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# noVNC 최신 버전 직접 설치
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc \
    && git clone https://github.com/novnc/websockify.git /opt/novnc/utils/websockify

WORKDIR /game
COPY build/main ./build/main
COPY assets/ ./assets/
RUN chmod +x ./build/main

COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["/start.sh"]