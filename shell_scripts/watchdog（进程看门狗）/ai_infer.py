#!/usr/bin/python3
import time
heartbeat='/home/panxuqian/watchdog/heartbeat.txt'
while 1==1:
    print('AI推理中...')
    with open(heartbeat,'w') as f:
        f.write(str(time.time()))
    time.sleep(2)
