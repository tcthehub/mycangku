#!/bin/bash
#统计/var/log/有多少个文件，并显示这些文件名
#使用ls递归显示所有，再判断是否为文件，如果是文件则技术器加1
sum=0
for i in `find /var/log/  -type f`
do
	[ -f $i ] && let sum++  && echo "文件名：$i"
done
echo 总文件的数量为：$sum
