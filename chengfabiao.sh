#!/bin/bash
for i in {1..9}
do
	for j in `seq $i`
	do
		echo -n "$j*$i=$[j*i] "
	done
	echo
done
