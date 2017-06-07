#!/system/bin/sh

mount -o remount,rw /;
mount -o rw,remount /system

# Knox set to 0 on working system
/sbin/resetprop -n ro.boot.warranty_bit "0"
/sbin/resetprop -n ro.warranty_bit "0"

# Fix some safetynet flags
/sbin/resetprop -n ro.boot.veritymode "enforcing"
/sbin/resetprop -n ro.boot.verifiedbootstate "green"
/sbin/resetprop -n ro.boot.flash.locked "1"
/sbin/resetprop -n ro.boot.ddrinfo "00000001"

#-------------------------
# TWEAKS
#-------------------------

    # SD-Card Readhead
    echo "2048" > /sys/devices/virtual/bdi/179:0/read_ahead_kb;

    # Internet Speed
    echo "0" > /proc/sys/net/ipv4/tcp_timestamps;
    echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse;
    echo "1" > /proc/sys/net/ipv4/tcp_sack;
    echo "1" > /proc/sys/net/ipv4/tcp_tw_recycle;
    echo "1" > /proc/sys/net/ipv4/tcp_window_scaling;
    echo "5" > /proc/sys/net/ipv4/tcp_keepalive_probes;
    echo "30" > /proc/sys/net/ipv4/tcp_keepalive_intvl;
    echo "30" > /proc/sys/net/ipv4/tcp_fin_timeout;
    echo "404480" > /proc/sys/net/core/wmem_max;
    echo "404480" > /proc/sys/net/core/rmem_max;
    echo "256960" > /proc/sys/net/core/rmem_default;
    echo "256960" > /proc/sys/net/core/wmem_default;
    echo "4096,16384,404480" > /proc/sys/net/ipv4/tcp_wmem;
    echo "4096,87380,404480" > /proc/sys/net/ipv4/tcp_rmem;

#-------------------------
# KERNEL INIT VALUES
#-------------------------

    # Enable Dynamic Fsync
    echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active

    # Enable Powersuspend
    echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_earlysuspend

# init.d support
if [ ! -e /system/etc/init.d ]; then
   mkdir /system/etc/init.d
   chown -R root.root /system/etc/init.d
   chmod -R 755 /system/etc/init.d
fi

# start init.d
for FILE in /system/etc/init.d/*; do
   sh $FILE >/dev/null
done;

