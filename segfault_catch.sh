#!/bin/bash
user=${base%%/*}
LOCKING=$$
USAGE="usage: $0 <grep pattern> <binary> [-s <strace file][-u <user>(DISABLED)]"
if [ $# < 2 ] ; then
  echo $USAGE
  exit 1;
fi
LOCK_FILE=/tmp/${LOCKING}.fault

if [ -f "$LOCK_FILE" ]; then
  echo "process id $LOCKING exists."
  ps -up $LOCKING
  exit 37;
fi

trap "rm -f $LOCK_FILE" EXIT
touch $LOCK_FILE

x=1; while [ $x = 1 ]; 
  do pid=$(ps afux|grep $user|grep $1|grep -v defunct|awk '{print $2}') 
  if [ $pid ]; 
    then x=0; 
  fi; 
  done
gdb -return-child-result -ex run -ex "thread apply all bt" -ex "quit" $2 -p $pid
#while [ $x = 1 ]; do process=$(pgrep -u $user); if [ $pid ]; then x=0; fi;  done; strace -vvttf -s 256  -p $pid 2>&1| tee ./$LOCKING.strace
#grep rw-p /proc/$pid/maps | sed -n 's/^\([0-9a-f]*\)-\([0-9a-f]*\) .*$/\1 \2/p' | while read start stop; do gdb --batch --pid $pid -ex "dump memory $1-$start-$stop.dump 0x$start 0x$stop"; done
#tail -32768 /var/log/messages|grep segfault|while read ; do echo -e "\n$REPLY" ; echo $REPLY|grep -oP '(?<=ip )[0-9a-f]+(?= sp)'|sort|uniq|xargs -I{} gdb /usr/bin/php --batch --ex 'x/1wx 0x{}' ;done
