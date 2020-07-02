FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
  && mkdir /run/mysqld \
  && apk -U add mariadb mariadb-client

COPY entrypoint.sh /usr/local/bin/

VOLUME ["/var/lib/mysql", "/var/lib/backup"]

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]

EXPOSE 3306

CMD ["mysqld", "-uroot"]