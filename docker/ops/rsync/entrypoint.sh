#!/bin/sh

if [ -z "${ROLE}" ]; then
	echo >&2 'ROLE is required, options: [server client]'
	exit 1
fi

if [ "server" = "$ROLE" ]; then
	echo "$USER:$PASS" > /etc/rsyncd.secrets
	chmod 0400 /etc/rsyncd.secrets

	cat <<-EOF > /etc/rsyncd.conf
		pid file = /var/run/rsyncd.pid
		log file = /dev/stdout
		timeout = 300
		max connections = 10
		uid = root
		gid = root
		[data]
		hosts deny = *
		hosts allow = ${ALLOW}
		read only = false
		path = /data
		comment = Rsync on docker
		auth users = ${USER}
		secrets file = /etc/rsyncd.secrets
	EOF

	exec /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf "$@"
elif [ "client" = "$ROLE" ] ; then
	if [ -z "${REMOTE_HOST}" ]; then
		echo >&2 'REMOTE_HOST is required'
		exit 1
	fi
	
	export RSYNC_PASSWORD=${PASS}
	# exec /usr/bin/rsync --avP /data/ rsync://${REMOTE_HOST}:{$REMOTE_PORT}/data/
	/usr/bin/rsync -vzrtopg --progress --port=${REMOTE_PORT} /data/ ${USER}@${REMOTE_HOST}::data "$@"
else
	echo >&2 'ROLE defined error, options: [server client]'
fi
