#!/bin/bash
read -p "請輸入你要創建的目錄名：" d
while [ -z $d ]
do
        read -p "請輸入你要創建的目錄名：" d
done
while [ -d $d ]
do
                echo "目錄$d已存在"
                read -p "請輸入你要創建的目錄名：" d
        while [ -z $d ]
        do
                read -p "請輸入你要創建的目錄名：" d
        done
done
read -p "是否要创建$d目录:(yes/no)" y
if [ $y == yes ] || [ $y == YES ];then
        mkdir $d
else
        exit
fi
read -p "是否要在改目錄下創建文件：（yes/no）" n
if [ $n == yes ] || [ $n == YES ];then
        read -p "請你輸入要創建的文件名：" f
        while [ -z $f ]
        do
                read -p "請你輸入要創建的文件名：" f
        done
fi
touch $d/$f
