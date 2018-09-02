#!/bin/bash
useradd(){
[ -z $1 ] && echo 请导入文件 && exit
[ ! -f $1 ] && echo 你导入的不是文件 && exit
for i in `cat $1`
do 
	id $i  &> /dev/null 
	[ $? -eq 0 ] && echo 用户$i已创建 && continue
	useradd $i
	echo 123456 | passwd --stdin $i  &> /dev/null
	echo  用户$1创建成功，初始密码为123456
done
}
useradd1(){
for i in `cat user.txt`
do
        useradd $i &> /dev/null && echo 123 | passwd --stdin $i  &> /dev/null && echo 用户$i创建成功,初始密
码是123 || echo 用户$i已存在
done
}
useradd2(){
while :
do
        read -p "请输入你想要创建的用户名："  user
        [ -z $user ] &&  continue
        id $user        &> /dev/null
        [ $? -eq 0 ] && echo 用户已创建 && continue
        [ $? -ne 0 ] && break
done
stty -echo
read -p "请你輸入用户密码：" pass
pass=${pass:-123456}
stty echo
useradd $user     &> /dev/null
echo $pass | passwd --stdin $user               &> /dev/null
echo 用戶$user創建成功！   
echo 用户密码为$pass
}
useradd3(){
while :
do
read -p "请输入你要创建的用户名：" user
[ -z $user ] && echo 请输入用户名 && exit 2
id $user  &> /dev/null
[ $? -eq 0 ] && echo 用户已创建 && continue
[ $? -ne 0 ] && break
done
stty -echo
read -p "请输入密码：" pass
stty echo
pass=${pass:-123456}
useradd $user
echo $pass | passwd --stdin $user  &> /dev/null && echo 用户$user已创建
}
useradd

