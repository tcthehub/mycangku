#!/bin/bash
#apache访问记录日志在/var/log/httpd/access_log中
#awk使用-F选项指定文件内容的分隔符时/或者:
#条件判断$7:$8大于等于13：30，并且小于等于14：30
#最后使用wc -l 统计这样的数据有多少行，即多少个
#日志文档内容里面，第一列是远程主机的IP地址，使用awk单独显示第一列即可

#统计13：30到14：30所有访问apache服务器的请求有多少个
awk -F"[/:]" '$7":"$8>="13:30" && $7":"$8<="14:00"' /var/log/httpd/access_log | wc -l

#统计所有访问的远程IP地址什么
awk -F"[/:]" '$7":"$8>="13:30" && $7":"$8<="14:00"{print $1}' /var/log/httpd/access_log

#统计每个远程IP访问了本机apache服务器几次
awk '{ip[$1]++}END{for(i in ip){print ip[i],i}}' /var/log/httpd/access_log
