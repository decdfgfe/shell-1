#!/bin/bash
source /etc/profile
log(){
echo `date '+%F %H:%M:%S'` $@ >>/var/log/reboottest.log
}
sleep 300
for process in nginx nsdpf mysqld;do
if [ $(ps aux | grep ${process} | grep -v grep |wc -l) -gt 0 ];then
        log ${process} success;
        else
        log ${process} failed;
fi
done
sleep 300
/sbin/reboot
