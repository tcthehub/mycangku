#!/bin/bash
myping(){
p=176.130.4
for i in {1..254}
do
ping -c3 -i0.1 -W1 $p.$i &> /dev/null && echo $p.$i up || echo $p.$i down &
done 
}
myping 

wait
