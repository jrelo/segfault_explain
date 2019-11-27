#!/bin/bash
for modu in $(cat /proc/modules|awk '{print $1}')
do
    if [[ $(od -A n /sys/module/$modu/taint) != " 000012" ]] ; then
        echo $modu
    fi
done
