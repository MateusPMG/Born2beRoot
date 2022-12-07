#!/bin/bash

echo "Operating system: $(. /etc/os-release; echo "$NAME" "$VERSION")"
echo "Kernel: $(uname -r)"
echo "Physical Processors, CPUs: $(nproc)"
echo "Virtual Processors, VCPUs: $(cat /proc/cpuinfo | grep processor | wc -l)"
free --mega| grep Mem | awk '{ printf("Total RAM:%.2fMb\nUsed RAM:%.2fMb\nUse Rate:%.2f%%\n", $2, $3, $3/$2 * 100.0) }'
df -h| grep '^/dev/' | grep -v '/boot$' | awk '{ud += $3} {fd+= $2} END {printf("Total Disk:%.2fGb\nUsed Disk:%.2fGb\nUse Rate:%.2f%\n", fd, ud, ud/fd*100) }'
top -bn1 | grep '^%Cpu' | cut -c 9- | awk '{printf("%.1f%%\n"), $1+$2+$3}'
last reboot 