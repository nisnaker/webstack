FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

RUN apk -U add mariadb mariadb-client

COPY entrypoint.sh /usr/local/bin/

VOLUME ["/var/lib/mysql", "/var/lib/backup"]

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]

EXPOSE 3306

CMD ["mysqld"]