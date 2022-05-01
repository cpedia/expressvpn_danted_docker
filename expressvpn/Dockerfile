
# Run expressvpn in a container

FROM debian:bullseye-slim

LABEL maintainer="benjamin@polkaned.net"

ENV ACTIVATION_CODE Code
ENV LOCATION smart
ENV PREFERRED_PROTOCOL auto
ENV LIGHTWAY_CIPHER auto

ARG APP=expressvpn_3.21.0.2-1_amd64.deb
COPY ${APP} /tmp/${APP}

RUN sed -i s/deb.debian.org/mirrors.cloud.tencent.com/g /etc/apt/sources.list \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
    && echo 'Asia/Shanghai' >/etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
    libterm-readkey-perl ca-certificates wget expect iproute2 curl  \
    procps libnm0 apt-utils dante-server net-tools telnet apt-file  \
    shadowsocks-libev \
    && rm -rf /var/lib/apt/lists/* \
    # && wget -q "https://github.com/cpedia/expressvpn_danted_docker/raw/master/expressvpn/Dockerfile/${APP}" -O /tmp/${APP} \
    && dpkg -i /tmp/${APP} \
    && rm -rf /tmp/*.deb\
    && apt-get purge -y --auto-remove wget

RUN apt-file update && apt-get -y --no-install-recommends install vim

COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh
# COPY danted_init /etc/init.d/danted
COPY danted.conf /etc/danted.conf
COPY install_v2ray.sh /usr/bin/install_v2ray.sh
COPY shadowsocks.conf /etc/shadowsocks-libev/config.json

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]

EXPOSE 1080
EXPOSE 1081
EXPOSE 80
EXPOSE 443