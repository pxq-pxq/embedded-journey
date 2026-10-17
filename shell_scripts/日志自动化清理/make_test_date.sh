#! /bin/bash
time=$(date "+%Y-%m-%d")
touch /home/panxuqian/test_logs/"${time}_ai.log"

file="/home/panxuqian/test_logs/${time}_ai.log"
echo "=== $time AI 推理服务启动 ===" > $file

echo "=== WARNING:NPU温度偏高" > $file
echo "=== INFO : 识别到目标物体，置信度 98% ===" >> $file
echo "===  AI 推理服务启动 ===" >> $file
echo "===$time 日志  ===" >> $file
