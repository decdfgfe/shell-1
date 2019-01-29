#!/bin/bash
# transfer reginfo_rtx.zip to reg server and do reg opration
info(){
        echo -e "\033[31m$@\033[0m"
}
zipfile=reginfo_rtx.zip
[ -f $zipfile ] && {
        info "copy ${zipfile} to remote server"
        scp -P 1218 $zipfile rzxsystemuser@192.168.50.95:/tmp/
}|| {
        info "$zipfile not exists,Plz get it"
        exit 1
}
info "execute reg.sh"
ssh rzxsystemuser@192.168.50.95 -p 1218 "cd /tmp/ && bash /apps/rtx/run_env/script/tool/reg.sh"

if [ $? -eq 0 ];then
        info "copy rzxregcode.rc to local directory"
        scp -P 1218 rzxsystemuser@192.168.50.95:/tmp/rzxregcode.rc .
        info "rm ${zipfile} and rzxregcode.rc"
        ssh rzxsystemuser@192.168.50.95 -p 1218 "rm -f /tmp/${zipfile} && rm -f /tmp/rzxregcode.rc"
fi
