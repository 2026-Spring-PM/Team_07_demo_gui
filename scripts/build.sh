#!/bin/sh
# =============================================================
#  build.sh - 게임 빌드 (POSIX sh 호환, w64devkit/busybox OK)
#  실행: bash scripts/build.sh  (또는 sh scripts/build.sh)
#  결과물: build/main (Linux/Mac) 또는 build/main.exe (Windows)
# =============================================================
set -e

# 스크립트 위치 기준으로 프로젝트 루트 이동 (BASH_SOURCE 안 씀 = 이식성)
SCRIPT_DIR=$(dirname "$0")
cd "$SCRIPT_DIR/.."
echo "[build] project root: $(pwd)"

mkdir -p build

# 플랫폼 판별: 컴파일러 타겟이 가장 확실
GXX_TARGET=$(g++ -dumpmachine 2>/dev/null || echo unknown)
echo "[build] compiler target: $GXX_TARGET"

case "$GXX_TARGET" in
    *mingw*|*windows*|*w64*)
        echo "[build] -> Windows (MinGW), g++ 직접 빌드"
        g++ -std=c++17 -O2 -static -static-libgcc -static-libstdc++ \
            src/*.cpp -Isrc -o build/main.exe \
            -luser32 -lgdi32 -lopengl32 -lgdiplus -lShlwapi -ldwmapi
        OUT="build/main.exe"
        ;;
    *darwin*|*apple*)
        echo "[build] -> macOS, g++ 직접 빌드"
        g++ -std=c++17 -O2 src/*.cpp -Isrc -o build/main \
            -framework OpenGL -framework Cocoa -framework IOKit \
            -framework CoreVideo -framework GLUT -framework Carbon \
            -framework ApplicationServices
        OUT="build/main"
        ;;
    *)
        echo "[build] -> Linux, g++ 직접 빌드"
        g++ -std=c++17 -O2 src/*.cpp -Isrc -o build/main \
            -lX11 -lGL -lpthread -lstdc++fs
        OUT="build/main"
        ;;
esac

echo ""
echo "==============================================="
echo "Build complete!  -> $OUT"
echo "Run:  ./$OUT"
echo "==============================================="
