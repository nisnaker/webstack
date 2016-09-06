FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

# https://hub.docker.com/r/betacz/rsync/

RUN apk add -U rsync && rm -rf /var/cache/apk/*
VOLUME /data
EXPOSE 873

COPY entrypoint.sh /usr/local/bin/

ENV USER 016e14bdcb83g80chcg513g4c17193f5
ENV PASS bf50e17fdf465808b2abj45e376bch3h
ENV ALLOW 192.168.0.0/16 172.16.0.0/12

ENV REMOTE_PORT 873

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
