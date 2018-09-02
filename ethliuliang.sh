#!/bin/bash
while :
do
	date
	ifconfig eth0 | awk '/RX p/{print "入站流量为 " $5};/TX p/{print "出站流量为 " $5}'
	sleep 2
	echo
done
jiankong2(){
while :
do
        ifconfig eth0 | grep packets
echo
        sleep 1
done
}
