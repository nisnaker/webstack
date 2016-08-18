FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk --update add mariadb mariadb-client \
	&& rm /etc/mysql/my.cnf

COPY my.cnf /etc/mysql/my.cnf
COPY entrypoint.sh /usr/local/bin/

VOLUME ["/var/lib/mysql", "/var/lib/backup"]

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]

EXPOSE 3306

CMD ["mysqld"]