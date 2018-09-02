#!/bin/bash
secip(){
awk '$6=="Failed" && $9!="invalid"{a[$11]++}END{for(i in a){print a[i],i}}' /var/log/secure | awk '$1>=3{print $2}';awk '/Invalid user/{b[$10]++}END{for(i in b){print b[i],i}}' /var/log/secure | awk '$1>=3{print $2}'
}
ip=(`secip | awk '{a[$1]++}END{for(i in a){print i}}'`)
for i in `seq 0 $[${#ip[*]}-1]`
do 
	firewall-cmd --permanent --zone=block --add-source=${ip[i]}
	firewall-cmd --reload
done

