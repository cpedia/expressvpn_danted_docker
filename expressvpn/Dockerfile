
# Run expressvpn in a container

FROM debian:bullseye-slim

LABEL maintainer="benjamin@polkaned.net"

ENV ACTIVATION_CODE Code
ENV LOCATION smart
ENV PREFERRED_PROTOCOL auto
ENV LIGHTWAY_CIPHER auto

ARG APP=expressvpn_3.21.0.2-1_amd64.deb
COPY ${APP} /tmp/${APP}

RUN apt-get update && apt-get install -y --no-install-recommends \
    libterm-readkey-perl ca-certificates wget expect iproute2 curl procps libnm0 apt-utils \
    && rm -rf /var/lib/apt/lists/* \
    # && wget -q "https://github.com/cpedia/expressvpn_danted_docker/raw/master/expressvpn/Dockerfile/${APP}" -O /tmp/${APP} \
    && dpkg -i /tmp/${APP} \
    && rm -rf /tmp/*.deb

COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]

ENV MIRROR https://public.sockd.info/source/

ENV DANTE_VER 1.4.2
ENV DANTE_URL $MIRROR/dante-$DANTE_VER.tar.gz
ENV DANTE_FILE dante.tar.gz
ENV DANTE_TEMP /tmp/danted
ENV DANTE_DIR  /home/danted
ENV DANTE_CONFIG /home/danted/conf/sockd.conf
ENV DANTE_PASSWD /home/danted/conf/sockd.passwd

ENV LIBPAM_URL $MIRROR/libpam-pwdfile.zip
ENV LIBPAM_FILE libpam-pwdfile.zip
ENV LIBPAM_DIR libpam-pwdfile-master
ENV LIBPAM_DANTE /etc/pam.d/sockd

ENV CONFIG_GUESS "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD"
ENV CONFIG_SUB "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD"

#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpam0g-dev && \
    mkdir -p ${DANTE_TEMP} && cd ${DANTE_TEMP} && \
    wget ${DANTE_URL} -O ${DANTE_FILE} && \
    tar xzf ${DANTE_FILE} --strip 1 && \
    wget ${CONFIG_GUESS} -O config.guess && \
    wget ${CONFIG_SUB} -O config.sub && \
    ac_cv_func_sched_setscheduler=no ./configure --with-sockd-conf=${DANTE_CONFIG} --prefix=${DANTE_DIR} && \
    make && make install && \
    cd ${DANTE_TEMP} && \
    wget ${LIBPAM_URL} -O ${LIBPAM_FILE} && unzip ${LIBPAM_FILE} && cd ${LIBPAM_DIR} && \
    make && make install && \
    echo "auth required pam_pwdfile.so pwdfile ${DANTE_PASSWD}" > ${LIBPAM_DANTE} && \
    echo "account required pam_permit.so" >> ${LIBPAM_DANTE} && \
    rm -rf ${DANTE_TEMP} \
    && apt-get purge -y --auto-remove wget

ADD conf "${DANTE_DIR}/conf"
ADD script "${DANTE_DIR}/script"

WORKDIR ${DANTE_DIR}
EXPOSE 1080

CMD ["sbin/sockd", "-N", "4"]

