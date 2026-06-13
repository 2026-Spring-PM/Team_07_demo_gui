# 🧟 ZOMBIE FARM — Team 07

**좀비가 창궐한 세상. 당신은 살아남을 수 있을까?**

---

## 스토리

20XX년. 원인 불명의 좀비 바이러스가 전 세계를 뒤덮었다.
당신은 감염된 동생을 데리고 폐농장으로 도망쳤다.
낡은 라디오에서 Dr. Chen의 신호가 잡혔다.

*"농장에 연구소를 지어라. 좀비 샘플을 모아라. 내가 백신을 완성시키겠다."*

낮에는 농사를 짓고, 밤에는 좀비를 막아라.
백신을 완성해 이 지옥에서 탈출하라.

---

## 실행 방법

### 1. Docker 설치
https://docs.docker.com/get-docker/
설치 후 Docker Desktop 실행

### 2. Git 설치 (Windows만)
https://git-scm.com/downloads

### 3. 터미널 열기
- **Windows**: Git Bash 열기
- **Mac / Linux**: 터미널 열기

### 4. 클론 및 실행
```bash
git clone https://github.com/2026-Spring-PM/Team_07_demo_gui.git
cd Team_07_demo_gui
bash scripts/run.sh
```

### 5. 브라우저에서 접속
```
http://localhost:6080/vnc.html
```
**Connect** 클릭 → 게임 시작!

### 게임 종료
```bash
docker stop team07-farm
```

---

## 조작법

| 키 | 동작 |
|---|---|
| WASD / 방향키 | 이동 |
| SPACE | 상호작용 (건물·밭 근처에서) |
| ESC | 실내 나가기 |
| Enter | 확인 |

---

## 게임 목표

**백신 진행률 100%** 달성 = 클리어
탈출할 때 누가 곁에 있느냐에 따라 엔딩이 달라진다.
숨겨진 요소도 직접 찾아보자.

---

*Team 07 | Programming Methodology | Seoul National University | Spring 2026*
