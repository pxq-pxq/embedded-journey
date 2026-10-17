#!/bin/bash
log_dir="/home/panxuqian/test_logs"
backup_dir="/home/panxuqian/backup_logs"
time=$(date "+%Y-%m-%d")
log_mtime7=$(find "$log_dir" -name "*.log" -mtime +7)
echo -e "七天前文件一览\n$log_mtime7"
find "$log_dir" -name "*.log" -mtime +7 | tar -zcvf "$backup_dir/log_$time.tar.gz" -T -
backup_mtime7=$(find "$backup_dir" -name "*.tar.gz" -mtime -7)
echo "已打包$backup_mtime7"
find "$log_dir" -name "*.log" -mtime +7 -exec rm -f {} \;
find "$backup_dir" -name "*.tar.gz" -mtime +30 -exec rm -f {} \;

for (( i=0 ; i<=5 ; i++ ))
do
       echo  "清理完成"
done
