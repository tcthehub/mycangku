#!/bin/bash
p=176.130.4
i=1
while [ $i -le 254 ]
do
ping -c3 -i0.1 -W1 $p.$i  &> /dev/null && echo $p.$i up || echo $p.$i down > /dev/null &
let i++
done

