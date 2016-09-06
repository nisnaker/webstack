FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
	apk -U add mongodb

EXPOSE 27017

CMD ["mongod"]
