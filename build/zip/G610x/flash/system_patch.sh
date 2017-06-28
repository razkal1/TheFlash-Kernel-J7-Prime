#!/sbin/sh

rm -f /system/app/mcRegistry/ffffffffd0000000000000000000000a.tlbin

# Delete Wakelock.sh 
rm -f /magisk/phh/su.d/wakelock*
rm -f /su/su.d/wakelock*
rm -f /system/su.d/wakelock*
rm -f /system/etc/init.d/wakelock*


