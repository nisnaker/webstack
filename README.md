# webstack

Set the owner to linux user `webstack(901)`.

```
WEB:

docker run -d \
	--name mariadb \
	-p 3306:3306 \
	-e MYSQL_ROOT_PASSWORD=123456 \
	nisnaker/webstack:mariadb 

docker run -d \
	--name php-fpm \
	--link mariadb:mariadb \
	-v /localproject:/var/www \
	-w /var/www \
	nisnaker/webstack:php-fpm

docker run -d \
	--name nginx \
	--link php-fpm:php-fpm \
	-p 8080:80  \
	-v /localproject:/var/www \
	-w /var/www \
	nisnaker/webstack:nginx

docker run -d \
	--name redis \
	-p 6379:6379 \
	nisnaker/webstack:redis

docker run -d \
	--name mongodb \
	-p 27017:27017 \
	nisnaker/webstack:mongodb

----
RSYNC:

docker run --rm -it \
	--name rsync_server \
	-v /dst:/data \
	-e ROLE=server \
	-p 873 \
	nisnaker/webstack:rsync

docker run --rm -it \
	--name rsync_client \
	-v /src:/data \
	-e ROLE=client \
	-e REMOTE_HOST=172.17.0.1 \
	nisnaker/webstack:rsync

----
VSFTPD:

docker run --rm -it \
	--name vsftpd \
	-p 20-21:20-21 \
	-p 21100-21110:21100-21110 \
	-v $(pwd):/data \
	-e FTP_USER=admin \
	-e FTP_PASS="admin@123" \
	nisnaker/webstack:vsftpd

```

[example docker-compose.yml](https://github.com/nisnaker/webstack/blob/master/docker/docker-compose.yml)