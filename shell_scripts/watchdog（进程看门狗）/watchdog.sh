#!/bin/bash
while true
do
ai_infer="/home/panxuqian/watchdog/ai_infer.py"
process=$(ps -ef | grep ai_infer.py |grep -v grep | wc -l)
date_day=$(date "+%Y-%m-%d")
true_logs="/home/panxuqian/watchdog/watchdog_logs/${date_day}_true.log"
false_logs="/home/panxuqian/watchdog/watchdog_logs/${date_day}_false.log"
if [ $process -eq 0 ];then
	echo "进程死亡"
        echo "$(date '+%H:%M:%S')进程死亡" >> $false_logs
        #拉起进程
	echo "$(date '+%H:%M:%S')正在拉起进程" >> $false_logs
        nohup python3 "$ai_infer" > /dev/null 2>&1 &
	sleep 3
	process_1=$(ps -ef | grep ai_infer.py |grep -v grep | wc -l)
	if [ $process_1 -eq 0 ];then
		echo "$(date '+%H:%M:%S')拉起失败" >> $false_logs
	else
		echo "$(date '+%H:%M:%S')拉起成功" >> $false_logs
			
	fi

else
	 echo "进程存活"
        echo "$(date '+%H:%M:%S') --进程存活" >> $true_logs

fi
sleep 10

done


       	       

