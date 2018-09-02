#!/bin/bash
for i in {1..10}
do
	[ $i -eq 6 ] && continue
	echo 爸爸$i
done
echo 爹
