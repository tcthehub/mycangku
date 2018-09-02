#!/bin/bash
x=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
p=""
for i in {1..8}
do
	num=$[RANDOM%62]
	a=${x:num:1}
	p=$p$a
done
echo $p
