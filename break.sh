#!/bin/bash
for i in {1..10}
do
	[ $i -eq 5 ]  && break
	echo 爸爸$i
done
echo 爹
