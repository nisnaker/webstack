FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	&& apk -U add mongodb 

COPY mongod.conf /etc/mongod.conf

EXPOSE 27017

CMD ["mongod", "-f", "/etc/mongod.conf"]
