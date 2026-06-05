#!/usr/bin/env bash
# =============================================================
#  run.sh - Docker 컨테이너 안에서 게임 실행
#  실행: bash scripts/run.sh
# =============================================================
set -e

SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR/.."
PROJECT_ROOT=$(pwd)

IMAGE="chwoong/team_00_project:0.1.0"

# 이미지 없으면 pull
if ! docker image inspect "$IMAGE" &> /dev/null; then
    echo "[run] Docker 이미지 다운로드 중... (최초 1회)"
    docker pull "$IMAGE"
fi

# OS별 디스플레이 설정
OS="$(uname -s)"
case "$OS" in
    Linux*)
        xhost +local:docker 2>/dev/null || true
        DISPLAY_ENV="${DISPLAY:-:0}"
        X11_OPTS="-e DISPLAY=$DISPLAY_ENV -v /tmp/.X11-unix:/tmp/.X11-unix"
        ;;
    Darwin*|MINGW*|MSYS*|CYGWIN*)
        X11_OPTS="-e DISPLAY=host.docker.internal:0"
        ;;
    *)
        X11_OPTS=""
        ;;
esac

echo "[run] 게임을 시작합니다..."
docker run -it --rm \
    --platform linux/amd64 \
    $X11_OPTS \
    -v "$PROJECT_ROOT:/workspace" \
    --name team07-farm \
    "$IMAGE" \
    bash -c "cd /workspace && chmod +x ./build/main && ./build/main"
