#!/bin/bash
num=$[$RANDOM%10+1]
read -p "我有一個隨機數，你猜" cai
if [ $cai -eq $num ];then
	echo "牛逼，你猜中了，我會把鳳姐嫁給你的"
elif [ $cai -gt $num ];then
	echo "傻叉，你猜大了"
else
	echo "你真是個傻逼，猜小了"
fi

