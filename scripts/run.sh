#!/bin/bash
IMAGE="hellwase/team07-zombie-farm:1.0.0"

echo "============================================="
echo "  ZOMBIE FARM - Team 07"
echo "============================================="

if ! command -v docker &> /dev/null; then
    echo "[오류] Docker가 설치되어 있지 않습니다."
    echo "  -> https://docs.docker.com/get-docker/"
    exit 1
fi

if ! docker image inspect "$IMAGE" &> /dev/null; then
    echo "[정보] 이미지 다운로드 중... (최초 1회)"
    docker pull --platform linux/amd64 "$IMAGE"
fi

docker rm -f team07-farm 2>/dev/null || true

echo "[정보] 게임 시작 중..."
docker run -d \
    --platform linux/amd64 \
    --name team07-farm \
    -p 6080:6080 \
    "$IMAGE"

sleep 3

echo "============================================="
echo "  브라우저에서 아래 주소를 열어주세요:"
echo ""
echo "  http://localhost:6080/vnc.html"
echo ""
echo "  종료: docker stop team07-farm"
echo "============================================="
