FROM alpine:3.9

RUN apk add --no-cache \
  bash \
  bind-tools \
  curl \
  file \
  iperf \
  less \
  netcat-openbsd \
  openssh \
  openssl \
  python2

RUN curl -sSLo /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-258.0.0-linux-x86_64.tar.gz && \
  echo "7bb5701cb0107e59b3a3e2318252dc416722ac7c0d70fea84ba5fe92f7acd43f  /tmp/google-cloud-sdk.tar.gz" | sha256sum -c - && \
  tar zxf /tmp/google-cloud-sdk.tar.gz -C /opt && \
  rm /tmp/google-cloud-sdk.tar.gz
RUN /opt/google-cloud-sdk/install.sh \
  --quiet \
  --usage-reporting false \
  --rc-path /etc/profile.d/gcloud.sh \
  --command-completion true \
  --path-update true

RUN curl -sSLo /usr/local/bin/gdrive "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download" && \
  echo "f31b441c5cdb835ee69849a62856e35c17954fd5b600f6de8a6f5d7bd7bf0420  /usr/local/bin/gdrive" | sha256sum -c - && \
  chmod +x /usr/local/bin/gdrive

RUN curl -sSLo /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/v2.1.1/speedtest.py && \
  echo "78167ef0ccb4cc7b33c7314da395c7740a91e5f7f4e0d761c48039891f943b47  /usr/local/bin/speedtest-cli" | sha256sum -c - && \
  chmod +x /usr/local/bin/speedtest-cli

CMD ["/bin/bash", "--login"]
