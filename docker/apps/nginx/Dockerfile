FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk --update add nginx \
    && addgroup -g 901 -S webstack \
    && adduser -u 901 -D -S -G webstack webstack

COPY nginx.conf /etc/nginx/nginx.conf
COPY php.conf /etc/nginx/php.conf
COPY fastcgi_params /etc/nginx/fastcgi_params
COPY servers /etc/nginx/servers

RUN sed -ri 's/user  nobody/user  webstack/' /etc/nginx/nginx.conf \
	&& NPROC=$(getconf _NPROCESSORS_ONLN) \
	&& sed -ri "s/worker_processes  1/worker_processes  ${NPROC}/" /etc/nginx/nginx.conf


EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]