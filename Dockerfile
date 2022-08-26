FROM debian:bullseye-slim

RUN apt-get update -y && \
  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    dnsutils \
    file \
    gnupg \
    iperf \
    iputils-ping \
    less \
    netcat-openbsd \
    openssh-client \
    && \
  rm -rf /var/lib/apt/lists/*

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk-buster main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
  apt-get update -y && \
  apt-get install google-cloud-cli -y && \
  rm -rf /var/lib/apt/lists/*

RUN curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash && \
  apt-get install -y speedtest-cli && \
  rm -rf /var/lib/apt/lists/*
