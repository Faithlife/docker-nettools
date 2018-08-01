FROM alpine

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
RUN curl -sSL https://storage.googleapis.com/pub/gsutil.tar.gz | tar zxC /opt
RUN echo "export PATH=\$PATH:/opt/gsutil" > /etc/profile.d/gsutil.sh

RUN curl -sSLo /usr/local/bin/gdrive "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download" && \
  echo "f31b441c5cdb835ee69849a62856e35c17954fd5b600f6de8a6f5d7bd7bf0420  /usr/local/bin/gdrive" | sha256sum -c - && \
  chmod +x /usr/local/bin/gdrive

RUN curl -sSLo /usr/local/bin/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py && \
  chmod +x /usr/local/bin/speedtest-cli

CMD ["/bin/bash", "--login"]
