#!/bin/bash
for i in {1..10}
do
	[ $i -eq 7 ] && exit
	echo 爸爸$i
done
echo 爹
