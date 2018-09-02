#!/bin/bash
while :
do
	echo -ne "\033[45m \033[0m"
	sleep 0.3
done &
[ $USER == root ] && yum -y install vsftpd &> /dev/null || echo 用户不是管理员
kill -9 $!
echo
