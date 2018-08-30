#!/bin/sh

if [ "$1" = 'mysqld' -a ! -d "/var/lib/mysql/mysql" ]; then

	# check MYSQL_ROOT_PASSWORD
	if [ -z "${MYSQL_ROOT_PASSWORD}" ]; then
		echo >&2 'MYSQL_ROOT_PASSWORD is required for database initialization'
		exit 1
	fi

	echo 'Initializing database'
	mysql_install_db --rpm
	echo 'Database initialized'

	# set password of root

	mysqld --skip-networking &
	pid="$!"

	for i in `seq 0 30`; do
		if echo 'SELECT 1' | mysql --protocol=socket -uroot &> /dev/null; then
			break
		fi

		echo 'Mysqld init in process...'
		sleep 1
	done

	if [ "$i" = '30' ]; then
		echo >&2 'Mysqld init error'
		exit 1
	fi

	# init user

	MYSQL_VIEWER_PASSWORD=`cat /dev/urandom | tr -cd 'a-j0-9' | head -c 32`

	mysql --protocol=socket -uroot <<-SQL
		-- https://github.com/docker-library/mariadb/blob/master/10.1/docker-entrypoint.sh
		-- What's done in this file shouldn't be replicated
		-- or products like mysql-fabric won't work
		SET @@SESSION.SQL_LOG_BIN=0;
		DELETE FROM mysql.user ;
		FLUSH PRIVILEGES ;

		CREATE USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
		GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION ;

		-- add a user for php-fpm
		CREATE USER 'php'@'172.17.%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
		GRANT ALL ON *.* TO 'php'@'172.17.%' WITH GRANT OPTION ;

		-- add a read-only user: viewer
		CREATE USER 'viewer'@'%' IDENTIFIED BY '${MYSQL_VIEWER_PASSWORD}' ;
		REVOKE ALL PRIVILEGES ON *.* FROM 'viewer';
		GRANT SELECT ON *.* TO 'viewer'@'%';

		DROP DATABASE IF EXISTS test ;
		FLUSH PRIVILEGES ;
		SET @@SESSION.SQL_LOG_BIN=1;
	SQL

	# mysqladmin -uroot --protocol=socket password "${MYSQL_ROOT_PASSWORD}"

	echo ${MYSQL_VIEWER_PASSWORD} > /var/lib/mysql/viewer.passwd


	if ! kill -s TERM "$pid" || ! wait "$pid"; then
		echo >&2 "Mysqld init process failed."
	fi

fi

exec "$@"