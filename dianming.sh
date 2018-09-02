#!/bin/bash
#该脚本，需要提前准备一个user.txt文件
#该文件中需要包含所有姓名的信息，一行一个姓名，脚本每次随即显示一个姓名
user=(`cat $1`)
user=${#user[*]}
while :
do
	clear
	num=$[RANDOM%user+1]
	sed -n  "${num}p" $1
	sleep 0.03
done

#while :
#do
##统计user文件中有多少个用户
#	line=`cat user.txt | wc -l`
#	num=$[RANDOM%line+1]
#	sed -n  "${num}p"  user.txt
#	sleep 0.2
#	clear
#done
