#!/bin/bash
#连续数字的加法运算，从1到你指定的数字，执行脚本时需要跟参数
jiafa1(){
sum=0
for x in `seq $1`
do
	let sum=sum+x
done
echo 总和是：$sum
}
jiafa2(){
read -p "请输入一个数：" x
x=${x:-100}
sum=0
for i in `seq $x`
do
        let sum+=i
done
echo $sum
}
jiafa2
