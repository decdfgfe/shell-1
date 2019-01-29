#!/bin/bash
# off line reg 
# author:wuyang
# email:dengwuyang@1218.com.cn
info(){
	echo -e "\033[31m$@\033[0m"
}
__log(){
	echo `date '+%F %H:%M:%S'` $@>/tmp/regrtx.log
}
doreg=/apps/rtx/run_env/bin/RzxReg 
tmpdir=/tmp
zipfile=reginfo_rtx.zip
xmlfile=reginfo_rtx.xml
[ ! -f ${tmpdir}/$zipfile ] &&  {
	info "$zipfile" not exists
	exit 1
}
info "unzip $filename"

unzip ${tmpdir}/${zipfile} >/dev/null
[ -f ${tmpdir}/tmp/${xmlfile} ] && {
	$doreg ${tmpdir}/tmp/$xmlfile 2>/tmp/regrtx_failed.log
	if [ $? -eq 0 ];then
		info "reg file success"
		rm -f 
		__log "reg success"
		exit 0
	else
		info "reg file failed"
		__log "reg failed, see logfile /var/log/regrtx_failed.log" 
		exit 1
	fi
}
