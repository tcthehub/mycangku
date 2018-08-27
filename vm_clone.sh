#!/bin/bash
#第一步：定义函数，方便以后修改
menu(){
clear
echo "  ##############----说明----#################################"
echo "# 1. 脚本只适合每个虚拟机配1个IP"
echo "# 2. 主机名、网卡名、IP请一一对应"
echo "# 3. 请根据自己的电脑内存创建相应的数量"
echo "# 4. 虚拟机数量超过内存负荷，脚本会报错"
echo "# 5. 脚本需要当前目录有lnmp_soft.tar.gz文档"
echo "  ###########################################################"
echo
echo
read -p  "1.请输入你要克隆的虚拟机数量：" num
read -p  "2.请输入你需要创建的虚拟机的主机名（以空格分开）：" -a hostname
read -p  "3.请输入每个虚拟机的需要开启的网卡名（以空格分开）：" -a  eth
read -p  "4.请输入每个虚拟机的的新IP（以空格分开）：" -a ip
}
#创建虚拟机
vm_create(){
	clear
#script为录取的命令之后的操作命令以及命令的输出，并保存到指定的文件中，本例子保存到script.out，exit结束
	expect << EOF
	spawn script script.out
	expect "]#" 		{send  "clone-auto7\n"}
	expect "vms" 		{send  "$num\n"}
	expect "]#"		{send  "exit\n"}
	expect "]#"		{send  "exit\n"}
EOF
#过滤出script.out中新创建的虚拟机的名称，以方便后面命令的启动
awk '/created/{print $2}' script.out > rh7_node.txt
#也可以使用echo $num | clone-auto7 > rh7_node.txt 完成本操作,不过使用后没有屏幕输出
}
#为虚拟机修改主机名以及ip地址
vm_ip_up(){
	clear
# $i为for循环的取值，取值为创建的虚拟机的名字
	virsh start $i
	set timeout 60
#virsh console 虚拟机名  以控制台的方式控制虚拟机，不需要虚拟机的IP地址
#hostnamectl set-hostname 主机名  用命令修改主机名，永久生效
#nmcli device connect 网卡名  启用网卡，网卡没有配置文件，只能出与半启用的状态，配置好IP后才能生效
#expect ""  {send  "\003"} 上面的命令运行后，因无配置文件，无法回到命令行，\003的意思就是快捷键Ctrl+c，因为上一条命令需要一点时间，才能处于半启动状态，所以暂停5秒之后才、003
#${eth[x]}  调用数组eth中的第x个参数
	expect << EOF
	spawn  virsh console $i
	expect "^]"		{send  "\n"}
	expect "login"		{send  "root\n"}
	expect "密码" 		{send  "123456\n"}
	expect "]#"		{send  "hostnamectl set-hostname  ${hostname[x]}\n"}
	expect "]#"		{send  "nmcli device connect ${eth[x]}\n"}
	sleep 5
	expect ""		{send  "\003"}
	expect "]#"		{send  "nmcli connection modify ${eth[x]} ipv4.method manual ipv4.addresses ${ip[x]}/24 connection.autoconnect yes\n"}
	expect "]#"		{send  "nmcli connection up ${eth[x]}\n"}
	expect "]#"		{send  "exit\n"}
EOF
}
#为虚拟机搭建YUM仓库
vm_yum_create(){
#获取真机YUM源，截取虚拟机IP的网络位，得到对应真机的IP，不至于网段不同而导致YUM源不可用，前提是你的真机必须有那个网段，并且IP的主机位必须是254
#spawn ssh -o StrictHostKeyChecking=no 虚拟机 远程虚拟机不提示是否连接
#yum-config-manager --add YUM源 以命令的方式搭建YUM仓库
#sed -i 's/gpgcheck=1/gpgcheck=0/' /etc/yum.conf  修改YUM的主配置文件，让其不检测
	yum_base=${ip[x]%.*}.254
	yum_base=ftp://$yum_base/rhel7
	expect << EOF
	spawn ssh -o StrictHostKeyChecking=no ${ip[x]}
	expect "password"	{send  "123456\n"}
	expect "]#"		{send  "yum-config-manager --add $yum_base\n"}
	expect "]#"		{send  "sed -i 's/gpgcheck=1/gpgcheck=0/' /etc/yum.conf\n"}
	expect "]#"		{send  "yum repolist\n"}
	expect "]#"		{send  "exit\n"}
EOF
}
#发送虚拟机需要的tar包
vm_lnmp_scp(){
	expect << EOF
	spawn  scp lnmp_soft.tar.gz  ${ip[x]}:/root
	expect "password"	{send  "123456\n"}
	expect "]#"		{send  "exit\n"}
EOF
}

#第二步：运行函数
#x变量为for循环中运行函数时，函数调用数组的第x个数值，以0开始
menu
vm_create
x=0
for i in `cat rh7_node.txt`
do
	vm_ip_up
	vm_yum_create
	vm_lnmp_scp
let x++
done
