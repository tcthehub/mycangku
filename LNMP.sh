#!/bin/bash
#写出本脚本能安装的源码包的目录，本脚本目前仅支持安装Nginx、MySQL、PHP、varnish。若有新的源码包，可以添加到目录中间，不过你得会改脚本
#nginx版本，若版本不同，更换变量即可，但解压后的目录必须为压缩包名称
nginx=nginx-1.8.0.tar.gz
#mysql版本
mysql=mysql-5.6.25.tar.gz
#php版本
mhash=mhash-0.9.9.9.tar.gz
libmcrypt=libmcrypt-2.5.8.tar.gz
php=php-5.4.24.tar.gz
#varnish版本
varnish=varnish-3.0.6.tar.gz
menu(){
	clear
	echo "######################----Menu----#####################"
	echo "# 1.install Nginx"
	echo "# 2.install MySQL"
	echo "# 3.install PHP"
	echo "# 4.install varnish"
	echo "# 5.Exit Program"
	echo "#######################################################"
}

choice(){
	read -p "Please choice a menu[1-9]:" select
}

#nginx源码包的安装，只能安装nginx-1.8.0，若源码包不同，需要把下面的nginx-1.8.0.tar.gz改成安装的版本名，并且解压后的目录名也需要修改，否则会报错，提示没有源码包
install_nginx(){
	if [ -f $nginx ];then
		id nginx &> /dev/null || useradd -s /sbin/nologin nginx
		tar -xf $nginx
		cd ${nginx%.tar.*}
		yum -y install gcc pcre-devel openssl-devel zlib-level make
		./configure --prefix=/usr/local/nginx --with-http_ssl_module
		make
		make install
		ln -s /usr/local/nginx/sbin/nginx /usr/sbin/
		cd ..
	else
		echo "没有Nginx源码包"
		exit
	fi
}

#mysql源码包安装
install_mysql(){
	if [ -f $mysql ];then
		yum -y install gcc gcc-c++ cmake ncurses-devel perl
		id mysql &> /dev/null || useradd -s /sbin/nologin mysql
		tar -xf $mysql
		cd ${mysql%.tar.*}
		cmake
		make
		make install
		/usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql/data/ --basedir=/usr/local/mysql/
		chown -R root.mysql /usr/local/mysql
		chown -R mysql /usr/local/mysql/data
		/bin/cp -f /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld
		chmod +x /etc/init.d.mysqld
		/bin/cp -f /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf
		echo "/usr/local/mysql/lib/" >> /etc/ld.so.conf
		ldconfig
		echo "PATH=\$PATH:/usr/local/mysql/bin/" >> /etc/profile
		export PATH
	else
		echo "没有mysql源码包"
		exit
	fi
}

#php源码包安装
#安装php时没有指定启动哪些模块功能，如果用户需要可以根据实际情况自行添加额外功能如--with-gd等
install_php(){
	if [ -f $mhash ];then
		yum -y install gcc libxm12-devel
		tar -xf $mhash
		cd ${mhash%.tar.*}
		./configure
		make
		make install
		cd ..
		if [ ! -f /usr/lib/libmhash.so ];then
			ln -s /usr/local/lib/libmhash.so /usr/lib/
		fi
		ldconfig
	else
		echo "没有mhash源码包"
		exit
	fi

	if [ -f $libmcrypt ];then
		tar -xf $libmecrypt
		cd ${libmcrypt%.tar.*}
		./configure
		make
		make install
		cd ..
		if [ ! -f /usr/lib/libmcrypt.so ];then
			ln -s /usr/local/lib/libmcrypt.so /usr/lib/
		fi
		ldconfig
	else
		echo "没有libmcrypt源码包"
		exit
	fi

	if [ -f $php ];then
		tar -xf $php
		cd ${php%.tar.*}
		./configure --prefix=/usr/local/php5 --with-mysql=/usr/local/mysql --enable-fpm --enable-mbstring --with-mcrypt --with-mhash --with-config-file-path=/usr/local/php5/etc --with-mysqli=/usr/local/mysql/bin/mysql_config
		make && make install
		/bin/cp -f php.ini-production /usr/local/php5/etc/php.ini
		/bin/cp -f /usr/local/php5/etc/php-fpm.conf.default /usr/local/php5/etc/php_fpm.conf
		cd ..
	else
		echo "没有php源码包"
		exit
	fi
}

#varnish源码包安装
install_varnish(){
	if [ -f $varnish ];then
		yum -y install gcc readline-devel pcre-devel
		id varnish &> /dev/null || useradd -s /sbin/lonogin  varnish
		tar -xf $varnish
		cd ${varnish%.tar.*}
#使用configure,make,make install源码安装软件包
		./configure --prefix=/usr/local/varnish
		make && make install
#在源码包目录下，将相应的配置文件拷贝到Linux'系统文件系统中
#默认安装完成后，不会自动拷贝或安装配置文件到Linux系统，所以需要手动赋值配置文件
#并使用uuidgen生成一个随即密钥的配置文件
		cp redhat/varnish.initrc /etc/init.d/varnish
		cp redhat/varnish.sysconfig /etc/sysconfig/varnish
		cp redhat/varnish_reload_vcl /usr/bin/
		ln -s /usr/local/varnish/sbin/varnishd /usr/sbin/
		ln -s /usr/local/varnish/bin/* /usr/bin
		mkdir /etc/varnish
		cp /usr/local/varnish/etc/varnish/default.vcl /etc/varnish/
		uuidgen > /etc/varnish/secret
	else
		echo "没有varnish源码包"
		exit
	fi
}
while :
do
	menu
	choice
	case $select in
	1)
		install_nginx;;
	2)
		install_mysql;;
	3)
		install_php;;
	4)
		install_varnish;;
	5)
		exit;;
	*)
		echo Sorry!
		exit
	esac
done
