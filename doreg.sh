#!/bin/bash
# transfer reginfo_rtx.zip to reg server and do reg opration
zipfile=reginfo_rtx.zip
[ -f $zipfile ] && {
        scp -P 1218 $zipfile rzxsystemuser@192.168.50.95:/tmp/
}
ssh rzxsystemuser@192.168.50.95 -p 1218 "cd /tmp/ && bash /apps/rtx/run_env/script/tool/reg.sh"

if [ $? -eq 0 ];then
        scp -P 1218 rzxsystemuser@192.168.50.95:/tmp/rzxregcode.rc .
        ssh rzxsystemuser@192.168.50.95 -p 1218 "rm -f /tmp/$zipfile; rm -f rzxregcode.rc"
fi
