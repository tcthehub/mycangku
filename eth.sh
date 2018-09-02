#!/bin/bash
read -p "請輸入你要查看的網卡名:" eth
ifconfig "$eth" | grep inet           &> /dev/null
if [ $? -eq 0 ];then
        systemctl restart network
else
        echo "$eth不存在或者沒有設置IP" 
fi

