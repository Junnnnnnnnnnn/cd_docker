FROM jenkins/jenkins:lts

# Docker 설치를 위한 root 권한 설정
USER root

# APT 캐시 초기화 및 의존성 설치
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl gnupg lsb-release

# Docker GPG 키 및 레포지토리 추가
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Docker CLI 및 관련 패키지 설치
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Jenkins 사용자로 권한 복원
USER jenkins
