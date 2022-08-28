
# Run expressvpn in a container

FROM debian:bullseye-slim

RUN sed -i s/deb.debian.org/mirrors.cloud.tencent.com/g /etc/apt/sources.list \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
    && echo 'Asia/Shanghai' >/etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
    libterm-readkey-perl ca-certificates wget expect iproute2 curl  \
    procps libnm0 apt-utils dante-server net-tools telnet apt-file  \
    shadowsocks-libev \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove wget

RUN apt-file update && apt-get -y --no-install-recommends install vim

COPY entrypoint.sh /tmp/entrypoint.sh

COPY shadowsocks.conf /etc/shadowsocks-libev/config.json

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]

EXPOSE 1081