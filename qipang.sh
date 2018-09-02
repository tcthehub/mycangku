#!/bin/bash
lange(){
echo -ne "\033[46m  \033[0m"
}
baige(){
echo -ne "\033[47m  \033[0m"
}
myqipan(){
for i in {1..8}
do
	if [ $[i%2] -eq 1 ];then
		for x in {1..4}
		do
			lange && baige
		done
		echo
	else	
		for y in {1..4}
		do
			baige && lange
		done
		echo
	fi
done
}
dingqipan(){
for i in {1..8}
do
	for j in {1..8}
	do
		sum=$[i+j]
		if [ $[sum%2] -eq 0 ];then
		lange
	else
		baige
	fi
	done
	echo
done
}
dingqipan	
