# Balance Profile (Stock Values)

   # CPU 1
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   echo 343000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   echo 1586000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
   echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
   echo "19000 1274000:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
   echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
   echo 858000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
   echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
   echo "75 1170000:85" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
   echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/mode
   echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/mode
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
   echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
   echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/param_index
   echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/param_index
   chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
   echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration

   # CPU 2
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   echo 343000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   echo 1586000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
   echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
   echo "19000 1274000:39000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
   echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
   echo 858000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
   echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
   echo "75 1170000:85" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
   echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/mode
   echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/mode
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
   echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
   echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/param_index
   echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/param_index
   chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
   echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration

   # IO Scheduler
   echo deadline > /sys/block/sda/queue/scheduler
   echo 256 > /sys/block/sda/queue/read_ahead_kb
   echo deadline > /sys/block/mmcblk0/queue/scheduler
   echo 2048 > /sys/block/mmcblk0/queue/read_ahead_kb

   # Misc
   echo 1 > /sys/module/sync/parameters/fsync_enabled
   echo 1 > /sys/kernel/dyn_fsync/Dyn_fsync_active
   echo 0 > /sys/kernel/sched/gentle_fair_sleepers
   echo 1 > /sys/kernel/sched/arch_power
   echo 2 > /sys/kernel/power_suspend/power_suspend_mode
   echo 0 > /sys/class/lcd/panel/smart_on
   echo bic > proc/sys/net/ipv4/tcp_congestion_control
