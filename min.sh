#!/bin/bash
read -p "请输入多个数字："  -a  z
sum=$[${#z[*]}-1]
for x  in `seq 0 $sum`
do
	[ $x -eq $sum ] && break
	for y in `seq $[x+1] $sum`
	do
	if [ ${z[x]} -gt ${z[y]} ];then
		tmp=${z[x]}
		z[x]=${z[y]}
		z[y]=$tmp
	fi
	done
done
echo ${z[*]}
