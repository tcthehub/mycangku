#!/bin/bash
mem=`free -m | awk '/Mem/{print $4}'`
disk=`df -m | awk '/\/$/{print $4}'`
 [ $mem -lt 500 ] && echo "内存空间不足" | mail -s "error" root
 [ $disk -lt 1000 ] && echo "磁盘空间不足" | mail -s "error" root
