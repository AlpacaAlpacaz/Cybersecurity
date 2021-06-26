#!/bin/bash

OUTPUT=~/research1/sys_info.txt
IP=$(ip addr | grep inet | tail -2 | head -1)
FIND=$(find /home -type f -perm 777)
files=('/etc/passwd' '/etc/shadow')

for file in ${files[@]}
do
  ls -l $file
done

echo "Quick System Information Script"
date
echo "Machine Type Info: $MACHTYPE"
echo -e "Uname info: $(uname -a) \n"

echo "Hostname: $HOSTNAME"

echo -e "IP Information: $IP \n"

if [ ! -d ~/research1 ]
then
  mkdir ~/research1
fi

if [ -f ~/research1/sys_info.txt ]
then
  rm ~/research1/sys_info.txt
fi

$FIND > $OUTPUT
ps -eo user,pid,%cpu,%mem,cmd --sort=-%mem | head >> $OUTPUT
