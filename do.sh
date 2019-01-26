#!/bin/bash
while true;do
        for code in 00 05 06 07;do
                nohup bash lftp_failed_log_v2.sh >/dev/null 2>&1 &
        done

done
