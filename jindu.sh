#!/bin/bash
jindu(){
while :
do
	echo -n  "#"
	sleep 0.5
done
}
jindu   &
cp -a $1 $2
kill -9 $!
echo 拷贝完成！
