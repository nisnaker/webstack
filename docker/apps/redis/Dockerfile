FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

RUN apk add --no-cache --virtual=build-dependencies wget \
	&& apk -U add redis \
	&& wget http://raw.githubusercontent.com/antirez/redis/`redis-cli -v|awk '{print $2}'`/redis.conf -O /etc/redis.conf --no-check-certificate \
	&& apk del build-dependencies \
	&& sed -i 's/logfile ""/logfile "\/var\/log\/redis\/redis.log"/' /etc/redis.conf \
	&& sed -i 's/dir .\//dir \/var\/lib\/redis\//' /etc/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]
