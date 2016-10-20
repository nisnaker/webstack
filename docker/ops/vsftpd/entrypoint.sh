#!/bin/sh

if [[ ! -f /etc/vsftpd.conf ]]; then

	cp /etc/vsftpd/vsftpd.conf /etc/

	sed -i 's/anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd.conf
	sed -i 's/#local_enable=YES/local_enable=YES/' /etc/vsftpd.conf
	sed -i 's/#write_enable=YES/write_enable=YES/' /etc/vsftpd.conf
	echo -e "seccomp_sandbox=NO\npasv_enable=YES\npasv_min_port=21100\npasv_max_port=21110" >> /etc/vsftpd.conf
	echo -e "seccomp_sandbox=NO\n\npasv_enable=YES\npasv_min_port=21100\npasv_max_port=21110\n\nport_enable=YES\nconnect_from_port_20=YES\nftp_data_port=20" >> /etc/vsftpd.conf

	# mkdir /data
	adduser -h /data -g ftp -s /sbin/nologin ${FTP_USER} -D
	echo ${FTP_USER}:${FTP_PASS} | chpasswd > /dev/null
	chown -R ${FTP_USER}.ftp /data

	echo "Vsftpd is listening..."

fi

exec "$@"
