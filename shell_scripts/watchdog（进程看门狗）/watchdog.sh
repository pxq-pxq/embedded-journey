#!/bin/bash
while true
do
ai_infer="/home/panxuqian/watchdog/ai_infer.py"
process=$(ps -ef | grep ai_infer.py |grep -v grep | wc -l)
date_day=$(date "+%Y-%m-%d")
true_logs="/home/panxuqian/watchdog/watchdog_logs/${date_day}_true.log"
false_logs="/home/panxuqian/watchdog/watchdog_logs/${date_day}_false.log"
heartbeat="/home/panxuqian/watchdog/heartbeat.txt"
if [ $process -eq 0 ];then
	echo "进程死亡"
        echo "$(date '+%H:%M:%S')进程死亡" >> $false_logs
        #拉起进程
	echo "$(date '+%H:%M:%S')正在拉起进程" >> $false_logs
        nohup python3 "$ai_infer" > /dev/null 2>&1 &
	sleep 3 #给出重启进程时间
	process_1=$(ps -ef | grep ai_infer.py |grep -v grep | wc -l)
	if [ $process_1 -eq 0 ];then
		echo "$(date '+%H:%M:%S')拉起失败" >> $false_logs
	else
		echo "$(date '+%H:%M:%S')拉起成功" >> $false_logs
			
	fi

else	#心跳判断进程是否假死
	if [ -f "$heartbeat" ];then
		now=$(date "+%s") #获取时间戳
		last=$(stat -c %Y "$heartbeat")
		diff_time=$((now - last))
		if [ $diff_time -gt 180 ];then #判断停止时间是否大于三分钟
			echo "$(date '+%H:%M:%S')--检测到假死，强制重启" >> $false_logs
			pkill -9 -f ai_infer.py
			sleep 1 #给出清理进程时间
			nohup python3 "$ai_infer" > /dev/null 2>&1 &
			sleep 3 #给出进程重启时间
			echo "$(date '+%H:%M:%S')假死重启完成" >> $false_logs
		else 
			echo "$(date '+%H:%M:%S')心跳正常" >> $true_logs
		fi
	else
		#如果心跳文件不存在（刚启动或未生成）
		echo "$(date '+%H:%M:%S')--等待心跳文件" >> $true_logs
	fi
	echo "进程存活"
fi
sleep 10

done


       	       

