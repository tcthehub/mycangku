#!/bin/bash
game=(石头 剪刀 布)
num=$[RANDOM%3]
computer=${game[$num]}
#通过随机数获取计算机的出拳手势
#出拳的可能性保存在一个数组中，game[0],game[1],game[2]分别是3个不同的可能
echo 请根据下列提示选择您的出拳手势
echo 1、石头
echo 2、剪刀
echo 3、布

read -p "请选择1-3" person
case $person in
1)
	case $num in
	0)
		echo "平局";;
	1)
		echo "你赢了";;
	2)
		echo "你输了";;
	esac;;
2)
	case $num in
	0)
		echo "你输了";;
	1)
		echo "平局";;
	2)
		echo "你赢了";;
	esac;;
3)
	case $num in
	0)
		echo "你赢了";;
	1)
		echo "你输了";;
	2)
		echo "平局";;
	esac;;
*)
	echo  请输入1-3
esac

