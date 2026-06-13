#!/bin/bash
Xvfb :1 -screen 0 1350x800x24 &
sleep 1
cd /game
LIBGL_ALWAYS_SOFTWARE=1 ./build/main &
sleep 1
x11vnc -display :1 -nopw -listen 0.0.0.0 -forever -shared &
sleep 1
/opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 6080