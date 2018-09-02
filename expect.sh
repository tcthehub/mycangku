#!/bin/bash
#安装expect软件
yum -y install expect  &> /dev/null
#删除~/.ssh/known_hosts后，ssh远程任何主机都会询问是否确认要连接该主机
rm -rf ~/.ssh/known_hosts
# ssh -o StrictHostKeyChecking=no server 远程任何主机都不会询问是否确认要连接该主机,使用该选项时，不需要删除~/.ssh/known_hosts也可以
ssh_httpd(){
read -p "请输入你要远程的IP地址：" ip
expect << EOF
spawn  ssh $ip
expect "yes/no"  	{send "yes\n"}
expect "password"		{send "123\n"}
expect "]#"		{send "yum -y install httpd\r"}
expect "]#"		{send "exit\r"}
EOF
}
sshtouch(){
for i in {20..80}
do
ping -c3 -i0.1 -W1 176.130.4.$i > /dev/null || continue
expect << EOF
spawn ssh -o StrictHostKeyChecking=no 176.130.4.$i
expect "password"       {send "Taren1\n"}
expect "#"              {send "touch /root/桌面/hello.txt\n"}
expect "#"              {send "exit"}
EOF
done
}
ssh_httpd
