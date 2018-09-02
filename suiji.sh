#!/bin/bash
num=$[RANDOM%100+1]
i=0
while : 
do
	read -p "我有一個1-100的隨機數，你猜" cai
	let i++
	if [ -z $cai  ];then
	exit
	fi
	if [ "$cai" -gt $num ];then
		echo "哥，你猜大了"
	elif [ "$cai" -lt $num ];then
		echo "哥，你猜小了"
	else
		echo "牛逼，你猜中了，我會把神仙姐姐嫁給你的"
		echo 你猜了$i次
	exit
	fi
done
