#!/bin/bash
for i in `ls /opt/*.$1`
do
	mv $i  ${i%.*}.$2
done
