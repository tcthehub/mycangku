#!/bin/bash
cat /proc/cpuinfo | grep -i genuineintel &> /dev/null
if [ $? -eq 0 ];then
	echo 该处理器厂家是Intel公司
else
	echo 该处理器厂家是AMD公司
fi
