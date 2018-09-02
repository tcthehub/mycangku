#!/bin/bash
while :
do
	echo -ne "\033[45m \033[0m"
	sleep 0.5
done &
yum clean all &> /dev/null
yum=`yum repolist | awk  '/repolist/{print $2}' | sed 's/,//'`
[ $yum  -le 0 ] && exit
yum -y install httpd mariadb-server mariadb mariadb-devel php php-mysql  &> /dev/null
systemctl start httpd mariadb 
systemctl enable httpd mariadb 
kill -9 $!
echo

