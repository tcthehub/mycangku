#!/bin/bash
read -p "请输入3个整数：" num1 num2 num3
if [ $num1 -gt $num2 ];then
	num1=$[(num1+num2)-(num2=$[(num1+num2)-num2])]
fi
if [ $num1 -gt $num3 ];then
        num1=$[(num1+num3)-(num3=$[(num1+num3)-num3])]
fi
if [ $num2 -gt $num3 ];then
        num2=$[(num2+num3)-(num3=$[(num2+num3)-num3])]
fi
echo $num1 $num2 $num3
