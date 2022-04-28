
# Run expressvpn in a container

FROM debian:bullseye-slim

LABEL maintainer="benjamin@polkaned.net"

ENV ACTIVATION_CODE Code
ENV LOCATION smart
ENV PREFERRED_PROTOCOL auto
ENV LIGHTWAY_CIPHER auto
ENV DEBIAN_FRONTEND=noninteractive

ARG APP=expressvpn_3.21.0.2-1_amd64.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
    libterm-readkey-perl ca-certificates wget expect iproute2 curl procps libnm0 apt-utils \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q "https://github.com/cpedia/expressvpn_danted_docker/raw/master/expressvpn/Dockerfile/${APP}" -O /tmp/${APP} \
    && dpkg -i /tmp/${APP} \
    && rm -rf /tmp/*.deb \
    && wget --no-check-certificate https://raw.github.com/Lozy/danted/master/install.sh -O /tmp/install.sh --port=1080 \
    && rm -rf /tmp/install.sh \
    && apt-get purge -y --auto-remove wget

COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]
