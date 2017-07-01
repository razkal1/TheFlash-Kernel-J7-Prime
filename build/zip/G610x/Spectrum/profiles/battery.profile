# Battery Profile

   # CPU 1
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   echo relaxed > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   echo 343000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   echo 1586000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

   # CPU 2
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   echo relaxed > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   echo 343000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   echo 1586000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq

   # IO Scheduler
   echo bfq > /sys/block/sda/queue/scheduler
   echo 1024 > /sys/block/sda/queue/read_ahead_kb
   echo bfq > /sys/block/mmcblk0/queue/scheduler
   echo 2048 > /sys/block/mmcblk0/queue/read_ahead_kb

   # Misc
   echo 1 > /sys/module/sync/parameters/fsync_enabled
   echo 1 > /sys/kernel/dyn_fsync/Dyn_fsync_active
   echo 0 > /sys/kernel/sched/gentle_fair_sleepers
   echo 1 > /sys/kernel/sched/arch_power
   echo 2 > /sys/kernel/power_suspend/power_suspend_mode
   echo 0 > /sys/class/lcd/panel/smart_on
   echo westwood > proc/sys/net/ipv4/tcp_congestion_control
   
   