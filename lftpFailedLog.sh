#!/bin/bash
#可通过Nat回流解决
# 解决因内部特殊环境导致审计日志无法正常上传到平台
mylog(){
         echo `date '+%F %H:%M:%S'` $@ >>/var/log/ftp.log
        }
failedLogpath=/appslog/log/inbusin/ecenter/fail
user=username
password=password
mac=00-E0-4C-1B-F7-31
case $1 in
        00)
        event=onoffevent
        ;;
        05)
        event=aevent
        ;;
        06)
        event=fevent
        ;;
        07)
        event=binary
        ;;
        *)
        echo "Usage: `basename $0` [00|05|06|07]"
        exit 1
        ;;
esac
if [ $(ls -tr $failedLogpath/*-${1}-*.zip | wc -l) -gt 0 ];then
for file in $(ls -at $failedLogpath/*-${1}-*.zip) ;do
lftp -u ${user},${password} ftp://10.12.109.132<<EOF
cd ${event}/${mac}
put $file
close
bye
EOF
if [ $? -eq 0 ];then
        rm -f $file
        if [ $? -eq 0 ];then
                mylog $file ok,rm ok
        else
                mylog $file ok
        fi
fi
done
exit 0
fi
