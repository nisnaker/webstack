FROM alpine:latest

MAINTAINER https://github.com/nisnaker/webstack

RUN apk -U add nginx certbot openssl

COPY nginx.conf /etc/nginx/nginx.conf
COPY php.conf /etc/nginx/php.conf
COPY fastcgi_params /etc/nginx/fastcgi_params
COPY servers /etc/nginx/servers
COPY cutlog.sh /usr/local/bin/cutlog.sh

RUN NPROC=$(getconf _NPROCESSORS_ONLN) \
	&& sed -i "s/worker_processes  1/worker_processes  ${NPROC}/" /etc/nginx/nginx.conf \
	&& echo '0	0	*	*	*	sh /usr/local/bin/cutlog.sh > /dev/null 2>&1' > /etc/crontabs/root \
	&& echo -e "#!/bin/sh\ncrond\nnginx -g 'daemon off;'" > /root/start_nginx.sh

EXPOSE 80 443

CMD ["sh", "/root/start_nginx.sh"]