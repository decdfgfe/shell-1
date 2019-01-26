#!/bin/bash
# usage nohup bash do.sh &
# suggest use suppervisor to monitor the script
while true;do
    if [ $(ls -l /appslog/log/inbusin/ecenter/fail/ | wc -l) -gt 0 ] ;then
        for code in 00 05 06 07;do
            nohup bash lftp_failed_log_v2.sh ${code} >/dev/null 2>&1 &
        done
        sleep 10
        else
            echo `date '+%F %H:%M:%S'` "logfile empty,no need to transfer" >>/var/log/ftp.log
        fi
done
