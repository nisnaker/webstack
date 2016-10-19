FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

ENV FTP_USER=admin \
	FTP_PASS=admin@123

COPY entrypoint.sh /root/entrypoint.sh

RUN apk add -U vsftpd && rm -rf /var/cache/apk/*

EXPOSE 20-21 21100-21110

ENTRYPOINT ["sh", "/root/entrypoint.sh"]

CMD vsftpd