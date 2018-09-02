#!/bin/bash
read -p "请出拳（石头、剪刀、布）："  peo
AI=$[RANDOM%3]
case $AI in
0)
	AI=石头;;
1)
	AI=剪刀;;
2)
	AI=布
esac
case $peo in
石头)
	case $AI in
	石头)
		echo  你出的是石头，电脑出的也是石头，平局;;
	剪刀)
		echo  你出的是石头，电脑出的是剪刀，你赢了;;
	布)
		echo  你出的是石头，电脑出的是布，你输了
	esac;;
剪刀)
	case $AI in
	石头)
		echo  你出的是剪刀，电脑出的也是石头，你输了;;
	剪刀)
		echo  你出的是剪刀，电脑出的是剪刀，平局;;
	布)
		echo  你出的是剪刀，电脑出的是布，你赢了
	esac;;
布)
	case $AI in
	石头)
		echo  你出的是布，电脑出的也是石头，你赢了;;
	剪刀)
		echo  你出的是布，电脑出的是剪刀，你输了;;
	布)
		echo  你出的是布，电脑出的是布，平局
	esac;;
*)
	echo  请出剪刀、石头、布
esac
