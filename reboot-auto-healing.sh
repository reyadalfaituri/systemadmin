#!/bin/bash
# This script is used to reload the instance when a the specific trasholds
# You can laod this sript by using cron @reboot .../reboot-auto-healing.sh
THRESHOLD=80  # Set the threshold cpu usability in percentage (It set on 80%)
SLEEP_INTERVAL=8  # Set the sleep interval in seconds (it set on 8 second), for the reboot to excute
while true; do    
    # Get the current CPU usage percentage    
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    # Compare the CPU usage with the threshold    
    if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
        echo "CPU usage exceeded $THRESHOLD%. Rebooting..."
        shutdown -r now  # Reboot the system
        exit 0    
    fi
    sleep $SLEEP_INTERVAL
done