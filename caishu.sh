#!/bin/bash
caishu1(){
AI=$[RANDOM%100+1]
x=0
while :
do
read -p "请输入一个1～100的数字：" num
[ -z $num ] && echo 未输入数字 && exit
expr $num + 1  &> /dev/null
[ $? -ne 0 ] && echo 你输入的不是数字 && exit 
[ $num -le 0 ] || [ $num -gt 100 ] && echo 输入不在范围内 && exit
[ $num -gt $AI ] && echo 你猜大了 && let x++ && continue
[ $num -lt $AI ] && echo 你猜小了 && let x++ && continue
[ $num -eq $AI ] && echo 你猜对了，一共猜了$x次 && exit
done
}
caishu2(){
num=$[RANDOM%10+1]
read -p "我有一個1-10的隨機數，你猜" cai
if [ "$cai" -eq "$num" ];then
        echo "牛逼，你猜中了，我會把鳳姐嫁給你的"
elif [ "$cai" -gt "$num" ];then
        echo "傻叉，你猜大了"
else
        echo "你真是個傻逼，猜小了"
fi
}
caishu1
