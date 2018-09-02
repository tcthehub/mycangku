#!/bin/bash
read -p "请出石头，剪刀，布中的一个：" peo
AI=$[RANDOM%3+1]
case $AI in
1)
	AI=石头;;
2)
	AI=剪刀;;
3)
	AI=布;;
esac
#规定 1.石头；2.剪刀；3.布
case $AI in
石头)
	case $peo in
	石头)
		echo 你出的是石头，电脑出的也是石头，平！;;
	剪刀)
		echo 你出的是剪刀，电脑出的是石头，你输了！;;
	布)
		echo 你出的是布，电脑出的是石头，你赢了！;;
	*)
		echo 你个傻逼，出错了！
	esac;;
剪刀)
	case $peo in
	石头)
		echo 你出的是石头，电脑出的也是剪刀，你赢了！;;
	剪刀)
		echo 你出的是剪刀，电脑出的是剪刀，平！;;
	布)
		echo 你出的是布，电脑出的是剪刀，你输了！;;
	*)
		echo 你个傻逼，出错了！
	esac;;
布)
	case $peo in
	石头)
		echo 你出的是石头，电脑出的也是布，你输了！;;
	剪刀)
		echo 你出的是剪刀，电脑出的是布，你赢了！;;
	布)
		echo 你出的是布，电脑出的是布，平！;;
	*)
		echo 你个傻逼，出错了！
	esac
esac
