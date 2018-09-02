#!/bin/bash
fangfa1(){
userbash=`awk -F: '/bash$/{print $1}' /etc/passwd | wc -l`
echo 能登陆的用户有$userbash个
}
fangfa2(){
userbash=`grep "bash$" /etc/passwd | wc -l`
echo 能登陆的用户有$userbash个
}
fangfa3(){
awk -F: '/bash$/{x++}END{print "能登陆的用户有"x"个"}' /etc/passwd
}
fangfa1
fangfa2
fangfa3
