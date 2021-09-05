#!/bin/bash

arch_time=`date +"%Y-%m-%d-%H-%M"`
name_log="/home/wikedsikj/Test_Jooble/$1"
folder_log="/home/wikedsikj/Test_Jooble/arch/"

sed -i '/192.168.0.100\|127.0.0.1\|^00:00\|[/]reinit$/d' $1
sed -i "s/[a-f0-9]\{32\}-[0-3][0-9][0-1][0-9]2[0-1][0-9][0-9][$]\([-+.']\w\+\)*@\w\+\([-.]\w\+\)*/*****/g" $1
zip -r "${folder_log}/$1-${arch_time}.zip" $name_log

count_arch=`find $folder_log -name "${1}*" | wc -l`

if ((count_arch > 10)); then
for ((i=1; i<=$(( count_arch-10 )); i++)) do
arch_copy=`find $folder_log -name "${1}*" | sort | head -n1`
scp -u $arch_copy  backuper@192.168.0.43:/var/log/storage
done
fi

cat /dev/null > $name_log
