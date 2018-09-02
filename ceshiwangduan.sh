#!/bin/bash
ip=192.168.4
for i in {1..254}
do
        ping -i0.1 -c3 -W1 $ip.$i  &> /dev/null && echo $ip.$i up || echo $ip.$i dowm  &
done
ceshi1(){
ip=192.168.4
x=1
while :
do
        [ $x -eq 255 ] && break
        ping -i0.1 -c3 -W1 $ip.$x  &> /dev/null && echo $ip.$x up || echo $ip.$x down &
        let x++
done
}
