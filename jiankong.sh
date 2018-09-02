#!/bin/bash
jiankong(){
ifconfig eth0 | awk '/inet /{print "本机的IP地址是： " $2}'
uptime | awk '{print "CPU的1，5，15分钟平均负载分别是： " $8$9$NF}'
ifconfig eth0 | awk '/RX p/{print "网卡的下载流量是： "  $5};/TX p/{print "网卡的上传流量是： "  $5}'
free -h | awk '/Mem/{print "内存的剩余容量是： "  $4}'
df -h | awk '/\/$/{print "磁盘剩余容量是： "  $4}'
wc -l /etc/passwd | awk '{print "计算机账户数量是： "  $1}'
echo 当前登录账户数量: `who | wc -l`
echo 计算机当前开启的进程数量:  `ps -aux | wc -l`
echo 本机已安装的软件包数量:  `rpm -qa | wc -l`
}
while :
do
jiankong | column -t
echo 
sleep 5
done
#本脚本，实现计算机各个性能数据监控的功能，具体监控项目如下：
#本机的IP地
#CPU负载
#网卡流量
#内存剩余容量
#磁盘剩余容量
#计算机账户数量
#当前登录账户数量
#计算机当前开启的进程数量
#本机已安装的软件包数量
#5秒运行一次
#Ctl+c结束脚本
#可以在脚本后面添加&把脚本放入后台运行，但不建议
