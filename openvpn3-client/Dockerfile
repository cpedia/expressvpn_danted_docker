
# Run expressvpn in a container

FROM ubuntu:20.04

LABEL maintainer="cpedia@gmail.com"

RUN sed -i s/deb.debian.org/mirrors.cloud.tencent.com/g /etc/apt/sources.list \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
    && echo 'Asia/Shanghai' >/etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https ca-certificates \
    curl software-properties-common

COPY openvpn-repo-pkg-key.pub /tmp/openvpn-repo-pkg-key.pub
COPY openvpn3-focal.list /etc/apt/sources.list.d/openvpn3.list

RUN apt-key add /tmp/openvpn-repo-pkg-key.pub

RUN apt-get update && apt-get install -y --no-install-recommends openvpn3

RUN apt-get update && apt-get install -y --no-install-recommends \
    libterm-readkey-perl wget expect iproute2  \
    procps libnm0 apt-utils dante-server net-tools telnet apt-file  \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove wget

RUN apt-file update && apt-get -y --no-install-recommends install vim

COPY ov3-chenping.ovpn /etc/ov3-chenping.ovpn

COPY danted.conf /etc/danted.conf

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]

EXPOSE 7777
