#!/usr/bin/env bash
# =============================================================
#  run.sh - Docker 컨테이너 안에서 빌드 + 게임 실행
#  실행: bash scripts/run.sh
#
#  GUI 게임이므로 X11 디스플레이 포워딩이 필요합니다.
#   - Linux: 호스트 X 서버 그대로 사용
#   - Windows: VcXsrv 등 X 서버 실행 후 DISPLAY 설정 필요
#   - macOS: XQuartz 실행 후 설정 필요
# =============================================================
set -e

SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR/.."; PROJECT_ROOT=$(pwd)
cd "$PROJECT_ROOT"

IMAGE="chwoong/team_00_project:0.1.0"

# 호스트 OS에 따라 DISPLAY / X11 설정
OS="$(uname -s)"
case "$OS" in
    Linux*)
        # 로컬 X 서버 접근 허용
        xhost +local:docker 2>/dev/null || true
        DISPLAY_ENV="${DISPLAY:-:0}"
        X11_OPTS="-e DISPLAY=$DISPLAY_ENV -v /tmp/.X11-unix:/tmp/.X11-unix"
        ;;
    Darwin*|MINGW*|MSYS*|CYGWIN*)
        # Windows / macOS: 호스트 IP로 DISPLAY (X 서버 별도 실행 필요)
        # 아래 host.docker.internal:0 은 VcXsrv/XQuartz 기준
        X11_OPTS="-e DISPLAY=host.docker.internal:0"
        ;;
    *)
        X11_OPTS=""
        ;;
esac

echo "[run] Docker 컨테이너에서 빌드 + 실행합니다..."
docker run -it --rm \
    --platform linux/amd64 \
    $X11_OPTS \
    -v "$(pwd):/workspace" \
    --name team07-farm \
    "$IMAGE" \
    bash -c "cd /workspace && bash scripts/build.sh && ./build/main"
