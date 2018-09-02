#!/bin/bash
read -p "请输入随便几个数字：" -a  num
sum=${#num[*]}
for i in `seq 0 $[sum-1]`
do
	for j in `seq $[i+1] $[sum-1]`
	do
	if [ ${num[i]} -gt ${num[j]} ];then
	tmp=${num[i]}
	num[i]=${num[j]}
	num[j]=$tmp
	fi
	done
done
echo ${num[*]}
paixu2(){
read -p "請輸入任意兩個數字" num1  num2
while [  -z $num1 ] || [ -z $num2 ]
do
read -p "請輸入任意兩個數字" num1  num2
done
if [ $num1 -ge $num2 ];then
        echo $num1 $num2
else
        echo $num2 $num1
fi
}
