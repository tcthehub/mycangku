#!/bin/bash
#本脚本针对RHEL7.2或者CentOS7.2
#本脚本需要提前准备一个qcow2格式的虚拟机模板，名称为/var/lib/libvirt/images/.rh7_template的虚拟机模板
#该脚本使用qemu-img命令快捷创建快照虚拟机
#脚本使用sed修改模板虚拟机的配置为加，将虚拟机名称、UUID、磁盘文件名、MAC地址
#exit code:
#65-> user input nothing
#66-> user input is not a number
#67-> user input out of range
#68-> vm disk image exists
IMG_DIR=/var/lib/libvirt/images
BASEVM=rh7_template
read -p "Enter VM number:" VMNUM
if [ $VMNUM -le 9 ];then
	VMNUM=0$VMNUM
fi

if [ -z $VMNUM ];then
	echo "You must input a number."
	exit 25
elif [ ${VMNUM} =  ~[a-z] ];then
	echo "You must input a number."
        exit 26
elif [ ${VMNUM} -lt 1 -o ${VMNUM} -gt 99 ];then
	echo "input out of range"
	exit 27
fi

NEWVM=rh7_node${VMNUM}
if [ -e $IMG_DIR/${NEWVM}.img ];then
	echo "File exists"
	exit 28
fi

echo -en "Creating Virtual Machine disk image......\t"
qemu-img create -f qcow2 -b $IMG_DIR/.${BASEVM}.img $IMG_DIR/${NEWVM}.img &> /dev/null
echo -e "\e[32;1m[OK]\e[0m"

#virsh dumpxml ${BASEVM} > /tmp/myvm.xml
cat /var/lib/libvirt/images/.rhel7.xml > /tmp/myvm.xml
sed -i "/<name>${BASEVM}/s/${BASEVM}/${NEWVM}/" /tmp/myvm.xml
sed -i "/uuid/s/<uuid>.*<\/uuid>/<uuid>$(uuidgen)<\/uuid>/" /tmp/myvm.xml
sed -i "/${BASEVM}\.img/s/${BASEVM}/${NEWVM}/" /tem/myvm.xml
#修改MAC地址，本例使用的是常量，每位使用该脚本的用户需要根据实际情况修改这些值
#最好这里使用可以变量，这样更适合于批量操作，可以克隆更多虚拟机
sed -i "/mac/s/a1/0c/"  /tmp/myvm.xml

echo -en "Defining neww virtual machine......\t\t"
virsh define /tmp/myvm.xml &> /dev/null
echo -e "\e[32;1m[OK]\e[0m"
