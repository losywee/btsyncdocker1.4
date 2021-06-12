FROM zburgermeiszter/glibc-alpine-armhf:2.22

MAINTAINER Zoltan Burgermeiszter <zoltan@burgermeiszter.com>

LABEL com.getsync.version="1.4.111"

RUN apk --update --no-cache add tar curl && \
    curl -o /tmp/btsync.tar.gz  -s -k -L "https://www.dropbox.com/sh/cpcjsw9pvp1d5wz/AABoGx2Spu5AR7PLEMsCsU9Ra/btsync_arm-1.4.111.tar.gz" && \
    mkdir -p /opt/btsync && \
    tar -xzf /tmp/btsync.tar.gz -C /opt/btsync && \
    mkdir -p /btsync/data && \
    mkdir -p /btsync/conf && \
    mkdir -p /btsync/folders && \
    curl -o /btsync/config/btsync.conf -s -k -L "https://raw.githubusercontent.com/FreemanZY/BTSync-DHT-Docker/master/btsync.conf" && \
    apk del tar curl && \
    rm -rf /var/cache/apk/* \

EXPOSE 8888 55555 55555/udp

VOLUME /btsync/data

ENTRYPOINT ["/opt/btsync/btsync"]
CMD ["--nodaemon","--config","/btsync/config/btsync.conf"]
