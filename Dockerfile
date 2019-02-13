FROM alpine:3.8

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

RUN mkdir /opt
RUN curl -sSLo /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-234.0.0-linux-x86_64.tar.gz && \
  echo "82ed3996e31b8cfa5ac4f39063234ecbbdd14e533d4f513d2d9a525da801bd7f  /tmp/google-cloud-sdk.tar.gz" | sha256sum -c - && \
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

RUN curl -sSLo /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py && \
  chmod +x /usr/local/bin/speedtest-cli

CMD ["/bin/bash", "--login"]
