FROM zburgermeiszter/glibc-alpine-armhf:2.22

MAINTAINER Zoltan Burgermeiszter <zoltan@burgermeiszter.com>

LABEL com.getsync.version="1.4.111"
RUN mkdir -p /opt/btsync
COPY btsync /opt/btsync/btsync

RUN mkdir -p /btsync/data && \
    mkdir -p /btsync/config && \
    ln -s /lib/ld-linux-armhf.so.3 /lib/ld-linux.so.3 && \
    mkdir -p /btsync/folders && \
    rm -rf /tmp/* /var/cache/apk/*

COPY btsync.conf /btsync/config/btsync.conf

RUN apk add --no-cache openssl-dev

EXPOSE 8888 55555 55555/udp

VOLUME /btsync/data

ENTRYPOINT ["/opt/btsync/btsync"]
CMD ["--nodaemon","--config","/btsync/config/btsync.conf"]
