
# Run expressvpn in a container

FROM ubuntu:20.04

LABEL maintainer="cpedia@gmail.com"

ENV TIME_ZONE Asia/Shanghai

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean \
    && rm -rf /tmp/* /var/cache/* /usr/share/doc/* /usr/share/man/* /var/lib/apt/lists/*


RUN sed -i s/deb.debian.org/mirrors.tencent.com/g /etc/apt/sources.list \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  \
    && echo 'Asia/Shanghai' >/etc/timezone

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https ca-certificates \
    curl software-properties-common gpg-agent

COPY openvpn-repo-pkg-key.pub /tmp/openvpn-repo-pkg-key.pub
COPY openvpn3-focal.list /etc/apt/sources.list.d/openvpn3.list

RUN apt-key add /tmp/openvpn-repo-pkg-key.pub

RUN apt-get update && apt-get install -y --no-install-recommends openvpn3 \
    iputils-ping

RUN apt-get update && apt-get install -y --no-install-recommends \
    libterm-readkey-perl wget expect iproute2  \
    procps libnm0 apt-utils dante-server net-tools telnet apt-file  \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove wget

RUN apt-file update && apt-get -y --no-install-recommends install vim

COPY ov3-chenping.ovpn  /etc/openvpn3/autoload/ov3-chenping.ovpn
COPY ov3-chenping.autoload  /etc/openvpn3/autoload/ov3-chenping.autoload

COPY entrypoint.sh /tmp/entrypoint.sh
COPY danted.conf /etc/danted.conf

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]

EXPOSE 7777
