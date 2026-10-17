#!/bin/bash
#检查磁盘使用率
function check_disk()
{
        f=$(df -h)
	s=$(df -h | awk '/\/dev\/sda3/{print $5}' | tr -d '%')

	echo $f
	echo "磁盘使用率：$s"
	if [ $s -gt 80 ];then
		echo "红色警告"
	else
		echo  "磁盘正常"
	fi

}
#检查内存余量
function check_mem()
{
	m=$(free -m | awk '/内存：/{print $4}')
	e=$(free -m)

	echo $e
	echo "剩余内存：$m"
	if [ $m -lt 500 ];then
		echo "内存不足！！！！"
	else 
		echo "内存充足"
	fi
	
}
#查看主要进程状态
function check_proc()
{
	proc_info=$(ps -aux | awk '/sshd/ {print }')
	p=$(ps -aux | awk '/sshd/ {print $8}' | head -n 1)

	echo -e "当前主要进程：\n $proc_info"
	echo -e "sshd的进程状态：$p"
	if [ "$p" = "Ss" ];then
		echo "活着"
	elif [ "$p" = "Z" ];then
		echo "进程死亡"
	elif [ "$p" = "T" ];then
		echo "进程暂停"
	fi
}
#启动函数
while [ 1 -eq 1 ]; 
do
read -p "请输入1：检查磁盘空间；2：检查内存情况；3：检查核心进程；4：退出;请输入：" nn
case $nn in
	"1")
		check_disk
		;;
	
	"2")
	
		check_mem
		;;
	"3")
		check_proc
		;;
	"4")
		break
		;;
	*)
		echo "请输入1-4来执行命令"
esac
done
